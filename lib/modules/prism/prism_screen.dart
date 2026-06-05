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

class PrismScreen extends StatefulWidget {
  const PrismScreen({super.key});

  @override
  State<PrismScreen> createState() => _PrismScreenState();
}

class _PrismScreenState extends State<PrismScreen> {
  final _formKey = GlobalKey<FormState>();
  final _decentrationController = TextEditingController(text: '4');
  final _powerController = TextEditingController(text: '-3.00');

  @override
  void dispose() {
    _decentrationController.dispose();
    _powerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Prismas',
      selectedRoute: AppRoutes.prism,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Regra de Prentice',
            subtitle: 'P = c x F, com descentralizacao em centimetros.',
            icon: Icons.view_in_ar,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      NumberField(
                        controller: _decentrationController,
                        label: 'Descentralizacao',
                        suffix: 'mm',
                      ),
                      NumberField(
                        controller: _powerController,
                        label: 'Potencia da lente',
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
                      label: const Text('Calcular prisma'),
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
                      label: 'Prisma induzido',
                      value: formatPlain(
                        provider.lastResult['prismDiopters'],
                        suffix: ' DP',
                      ),
                      icon: Icons.open_with,
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
    context.read<CalculatorProvider>().calculatePrism(
      decentrationMm: parseDecimal(_decentrationController.text),
      lensPower: parseDecimal(_powerController.text),
    );
  }
}
