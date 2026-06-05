import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../models/patient.dart';
import '../../providers/patient_provider.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/form_field_grid.dart';
import '../../widgets/responsive_page.dart';
import '../../widgets/section_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Pacientes',
      selectedRoute: AppRoutes.patients,
      child: ResponsivePage(
        children: [
          SectionCard(
            title: 'Cadastro de paciente',
            subtitle: 'Dados salvos no Firestore quando configurado.',
            icon: Icons.person_add,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormFieldGrid(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if ((value ?? '').trim().length < 3) {
                            return 'Informe pelo menos 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                        ),
                        validator: (value) {
                          if ((value ?? '').trim().length < 8) {
                            return 'Informe um telefone valido';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (value) {
                      final email = (value ?? '').trim();
                      if (email.isEmpty) {
                        return null;
                      }
                      if (!email.contains('@') || !email.contains('.')) {
                        return 'Informe um e-mail valido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Observacoes clinicas',
                    ),
                    minLines: 3,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Consumer<PatientProvider>(
                      builder: (context, provider, _) {
                        return FilledButton.icon(
                          onPressed: provider.isLoading ? null : _savePatient,
                          icon: provider.isLoading
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save),
                          label: const Text('Salvar paciente'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<PatientProvider>(
            builder: (context, provider, _) {
              return SectionCard(
                title: 'Historico',
                subtitle: provider.usesFirebase
                    ? 'Sincronizado com Cloud Firestore.'
                    : 'Modo local em memoria.',
                icon: Icons.history,
                child: _PatientList(provider: provider),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _savePatient() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<PatientProvider>();
    await provider.savePatient(
      Patient(
        id: '',
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        notes: _notesController.text.trim(),
        createdAt: DateTime.now(),
      ),
    );

    if (!mounted) {
      return;
    }

    if (provider.errorMessage == null) {
      _formKey.currentState!.reset();
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _notesController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paciente salvo com sucesso.')),
      );
    }
  }
}

class _PatientList extends StatelessWidget {
  const _PatientList({required this.provider});

  final PatientProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.errorMessage != null) {
      return Text(
        provider.errorMessage!,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      );
    }

    if (provider.patients.isEmpty) {
      return const Text('Nenhum paciente cadastrado ainda.');
    }

    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Column(
      children: [
        for (final patient in provider.patients)
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(patient.name),
              subtitle: Text(
                [
                  patient.phone,
                  if (patient.email.isNotEmpty) patient.email,
                  formatter.format(patient.createdAt),
                ].join(' | '),
              ),
              trailing: patient.notes.isEmpty
                  ? null
                  : Tooltip(
                      message: patient.notes,
                      child: const Icon(Icons.notes),
                    ),
            ),
          ),
      ],
    );
  }
}
