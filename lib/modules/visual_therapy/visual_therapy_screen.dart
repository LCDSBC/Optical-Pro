import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/form_parsers.dart';
import '../../providers/calculator_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/form_field_grid.dart';
import '../../widgets/metric_card.dart';
import '../../widgets/number_field.dart';
import '../../widgets/responsive_page.dart';
import '../../widgets/section_card.dart';

class VisualTherapyScreen extends StatefulWidget {
  const VisualTherapyScreen({super.key});

  @override
  State<VisualTherapyScreen> createState() => _VisualTherapyScreenState();
}

class _VisualTherapyScreenState extends State<VisualTherapyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _convergenceController = TextEditingController(text: '12');
  final _accommodationController = TextEditingController(text: '3');

  @override
  void dispose() {
    _convergenceController.dispose();
    _accommodationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Terapia visual',
      selectedRoute: AppRoutes.visualTherapy,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Relacao AC/A',
            subtitle: 'Apoio para analise de vergencia e acomodacao.',
            icon: Icons.psychology,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      NumberField(
                        controller: _convergenceController,
                        label: 'Convergencia acomodativa',
                        suffix: 'DP',
                      ),
                      NumberField(
                        controller: _accommodationController,
                        label: 'Acomodacao',
                        suffix: 'D',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calcular AC/A'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<CalculatorProvider>(
            builder: (context, provider, _) {
              return SectionCard(
                title: 'Resultado',
                icon: Icons.analytics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (provider.errorMessage != null)
                      Text(
                        provider.errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    MetricCard(
                      label: 'Relacao AC/A',
                      value: formatPlain(
                        provider.lastResult['acaRatio'],
                        suffix: ':1',
                      ),
                      icon: Icons.timeline,
                      helper: 'Compare com sinais, sintomas e testes clinicos.',
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<CalculatorProvider>().calculateAca(
      convergence: parseDecimal(_convergenceController.text),
      accommodation: parseDecimal(_accommodationController.text),
    );
  }
}
