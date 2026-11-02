import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_extensions.dart';
import '../../../domain/providers/app_launch_provider.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/meta_label.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../upcoming/presentation/add_upcoming_expense_sheet.dart';
import 'onboarding_actions.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final TextEditingController _budgetController = TextEditingController();
  int _step = 0;
  bool _isSaving = false;
  String? _errorText;

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final colors = Theme.of(context).extension<AppColorTokens>()!;

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing.xl),
          MetaLabel('STEP ${_step + 1} / 2', color: colors.textMuted),
          SizedBox(height: spacing.hero),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _step == 0
                  ? _BudgetStep(
                      key: const ValueKey('budget-step'),
                      controller: _budgetController,
                      errorText: _errorText,
                    )
                  : const _UpcomingStep(
                      key: ValueKey('upcoming-step'),
                    ),
            ),
          ),
          if (_step == 0) ...[
            PrimaryButton(
              label: 'NEXT',
              onPressed: _isSaving
                  ? null
                  : () {
                      final budget = int.tryParse(
                        _budgetController.text.replaceAll(',', ''),
                      );

                      if (budget == null || budget <= 0) {
                        setState(() {
                          _errorText = 'ENTER A VALID MONTHLY BUDGET';
                        });
                        return;
                      }

                      setState(() {
                        _errorText = null;
                        _step = 1;
                      });
                    },
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                            setState(() {
                              _step = 0;
                            });
                          },
                    child: const Text('BACK'),
                  ),
                ),
                SizedBox(width: spacing.md),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: _isSaving ? 'SAVING...' : 'DONE',
                      onPressed: _isSaving ? null : _completeSetup,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.md),
            TextButton(
              onPressed: _isSaving
                  ? null
                  : () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const AddUpcomingExpenseSheet(),
                        ),
                      );
                    },
              child: const Text('ADD UPCOMING'),
            ),
          ],
          SizedBox(height: spacing.xl),
        ],
      ),
    );
  }

  Future<void> _completeSetup() async {
    final budget = int.tryParse(_budgetController.text.replaceAll(',', ''));
    if (budget == null || budget <= 0) {
      setState(() {
        _step = 0;
        _errorText = 'ENTER A VALID MONTHLY BUDGET';
      });
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await ref.read(completeOnboardingProvider(budget).future);

    if (!mounted) {
      return;
    }

    ref.invalidate(appLaunchProvider);

    setState(() {
      _isSaving = false;
    });
  }
}

class _BudgetStep extends StatelessWidget {
  const _BudgetStep({
    required this.controller,
    required this.errorText,
    super.key,
  });

  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOW MUCH CAN YOU SPEND THIS MONTH?',
          style: textTheme.displayMedium,
        ),
        SizedBox(height: spacing.xl),
        TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          style: textTheme.displayLarge,
          decoration: InputDecoration(
            prefixText: '₩ ',
            hintText: '1,500,000',
            errorText: errorText,
            border: InputBorder.none,
          ),
        ),
        SizedBox(height: spacing.lg),
        const MetaLabel('SET VARIABLE SPENDING BUDGET ONLY'),
      ],
    );
  }
}

class _UpcomingStep extends StatelessWidget {
  const _UpcomingStep({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UPCOMING EXPENSES?',
          style: textTheme.displayMedium,
        ),
        SizedBox(height: spacing.xl),
        Text(
          'WE WILL ADD RESERVED EXPENSE INPUT NEXT.\nFOR NOW, FINISH SETUP AND LAND ON HOME.',
          style: textTheme.bodyLarge,
        ),
        SizedBox(height: spacing.lg),
        const MetaLabel('MVP STEP CONNECTED TO BUDGET ONLY'),
      ],
    );
  }
}
