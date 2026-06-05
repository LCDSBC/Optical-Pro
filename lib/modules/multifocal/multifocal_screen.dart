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

class MultifocalScreen extends StatefulWidget {
  const MultifocalScreen({super.key});

  @override
  State<MultifocalScreen> createState() => _MultifocalScreenState();
}

class _MultifocalScreenState extends State<MultifocalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController(text: '52');
  final _residualController = TextEditingController(text: '1.50');
  final _workDistanceController = TextEditingController(text: '40');

  @override
  void dispose() {
    _ageController.dispose();
    _residualController.dispose();
    _workDistanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Multifocal',
      selectedRoute: AppRoutes.multifocal,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Estimativa de adicao',
            subtitle:
                'Combina idade, acomodacao residual e distancia de trabalho.',
            icon: Icons.auto_awesome,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      NumberField(
                        controller: _ageController,
                        label: 'Idade',
                        integerOnly: true,
                      ),
                      NumberField(
                        controller: _residualController,
                        label: 'Acomodacao residual',
                        suffix: 'D',
                      ),
                      NumberField(
                        controller: _workDistanceController,
                        label: 'Distancia de trabalho',
                        suffix: 'cm',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calcular adicao'),
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
                      label: 'Adicao sugerida',
                      value: formatDiopter(provider.lastResult['nearAdd']),
                      icon: Icons.add_circle,
                      helper:
                          'Use como apoio clinico, nao como prescricao isolada.',
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
    context.read<CalculatorProvider>().calculateMultifocal(
      age: parseInteger(_ageController.text),
      residualAccommodation: parseDecimal(_residualController.text),
      workingDistanceCm: parseDecimal(_workDistanceController.text),
    );
  }
}
