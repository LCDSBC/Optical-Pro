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

class ContactLensScreen extends StatefulWidget {
  const ContactLensScreen({super.key});

  @override
  State<ContactLensScreen> createState() => _ContactLensScreenState();
}

class _ContactLensScreenState extends State<ContactLensScreen> {
  final _formKey = GlobalKey<FormState>();
  final _powerController = TextEditingController(text: '-8.00');
  final _vertexController = TextEditingController(text: '12');

  @override
  void dispose() {
    _powerController.dispose();
    _vertexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Lentes de contato',
      selectedRoute: AppRoutes.contactLens,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Conversao por vertice',
            subtitle: 'Formula: FLC = F / (1 - dF).',
            icon: Icons.adjust,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      NumberField(
                        controller: _powerController,
                        label: 'Potencia do oculos',
                        suffix: 'D',
                      ),
                      NumberField(
                        controller: _vertexController,
                        label: 'Distancia vertice',
                        suffix: 'mm',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FilledButton.icon(
                      onPressed: _calculate,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Converter para LC'),
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
                      label: 'Potencia sugerida para LC',
                      value: formatDiopter(
                        provider.lastResult['contactLensPower'],
                      ),
                      icon: Icons.remove_red_eye,
                      helper: 'Arredondado em passos de 0.25 D.',
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
    context.read<CalculatorProvider>().calculateContactLens(
      spectaclePower: parseDecimal(_powerController.text),
      vertexDistanceMm: parseDecimal(_vertexController.text),
    );
  }
}
