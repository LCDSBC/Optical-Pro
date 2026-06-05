import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_provider.dart';
import '../../widgets/module_surface.dart';
import '../../widgets/premium_card.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final _name = TextEditingController();
  final _notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientProvider>().loadPatients();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();

    return ModuleSurface(
      title: 'Pacientes',
      subtitle: 'Cadastro rápido, histórico e observações clínicas.',
      maxWidth: 1040,
      child: Column(
        children: [
          PremiumCard(
            child: Column(
              children: [
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Nome do paciente',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _notes,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Observações clínicas',
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          await provider.addQuickPatient(
                            _name.text,
                            _notes.text,
                          );
                          if (provider.errorMessage == null && mounted) {
                            _name.clear();
                            _notes.clear();
                          }
                        },
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  label: const Text('Cadastrar paciente'),
                ),
              ],
            ),
          ),
          if (provider.errorMessage != null) ...[
            const SizedBox(height: 14),
            Text(
              provider.errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 22),
          if (provider.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 760 ? 2 : 1;
                return GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: columns == 2 ? 1.75 : 1.55,
                  children: [
                    for (final patient in provider.patients)
                      PremiumCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text(patient.name.characters.first),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    patient.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text('${patient.age} anos'),
                            const SizedBox(height: 8),
                            Text(
                              'Última visita: ${DateFormat('dd/MM/yyyy').format(patient.lastVisit)}',
                            ),
                            const SizedBox(height: 8),
                            Text(patient.notes),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
