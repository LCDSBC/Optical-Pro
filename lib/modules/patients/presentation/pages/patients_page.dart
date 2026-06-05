import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/app_card.dart';
import '../../../../widgets/responsive_scaffold.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/status_banner.dart';
import '../providers/patients_provider.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final _nameController = TextEditingController();
  final _documentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _documentController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientsProvider>();

    return ResponsiveScaffold(
      title: 'Pacientes',
      body: ListView(
        children: [
          SectionHeader(
            title: 'Pacientes',
            subtitle: provider.isRemoteEnabled
                ? 'Dados sincronizados com Cloud Firestore.'
                : 'Modo local ate configurar Firebase.',
          ),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _documentController,
                  decoration: const InputDecoration(labelText: 'Documento'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Observacoes clinicas',
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _savePatient,
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  label: const Text('Cadastrar paciente'),
                ),
              ],
            ),
          ),
          if (provider.errorMessage != null) ...[
            const SizedBox(height: 16),
            StatusBanner(message: provider.errorMessage!),
          ],
          const SizedBox(height: 24),
          Text(
            'Historico',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          if (provider.patients.isEmpty)
            const AppCard(
              child: Text('Nenhum paciente cadastrado ainda.'),
            )
          else
            ...provider.patients.map(
              (patient) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(patient.name),
                    subtitle: Text(
                      [
                        if (patient.phone != null) patient.phone,
                        if (patient.clinicalNotes != null) patient.clinicalNotes,
                      ].join(' - '),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _savePatient() async {
    await context.read<PatientsProvider>().createPatient(
          name: _nameController.text,
          document: _documentController.text,
          phone: _phoneController.text,
          clinicalNotes: _notesController.text,
        );

    if (!mounted) {
      return;
    }

    final provider = context.read<PatientsProvider>();
    if (provider.errorMessage == null) {
      _nameController.clear();
      _documentController.clear();
      _phoneController.clear();
      _notesController.clear();
    }
  }
}
