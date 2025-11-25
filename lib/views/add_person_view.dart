import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../viewmodels/person_list_viewmodel.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/theme_switch.dart';

class AddPersonView extends StatefulWidget {
  final Person? initial;

  const AddPersonView({super.key, this.initial});

  @override
  State<AddPersonView> createState() => _AddPersonViewState();
}

class _AddPersonViewState extends State<AddPersonView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _contactsCtrl;
  late final TextEditingController _githubCtrl;
  final List<String> _hobbyOptions = const [
    'Programming',
    'Design',
    'Music',
    'Travel',
    'Other',
  ];
  late String _selectedHobby;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _nameCtrl = TextEditingController(
      text: initial != null && initial.name.isNotEmpty
          ? '${initial.name} (copy)'
          : '',
    );
    _descriptionCtrl = TextEditingController(text: initial?.description ?? '');
    _contactsCtrl = TextEditingController(text: initial?.contacts ?? '');
    _githubCtrl = TextEditingController(text: initial?.githubUsername ?? '');
    final initHobby = initial?.hobby ?? _hobbyOptions.first;
    _selectedHobby = _hobbyOptions.contains(initHobby)
        ? initHobby
        : _hobbyOptions.last; // map unknown to 'Other'
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    _contactsCtrl.dispose();
    _githubCtrl.dispose();
    super.dispose();
  }

  bool _isSubmitting = false;
  String? _errorMessage;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final viewModel = context.read<PersonListViewModel>();
      final person = Person(
        name: _nameCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        hobby: _selectedHobby,
        contacts: _contactsCtrl.text.trim(),
        githubUsername: _githubCtrl.text.trim(),
      );

      await viewModel.addPerson(person);
      
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to save resume: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initial == null ? 'Додати резюме' : 'Дублювати резюме'),
        actions: const [
          ThemeSwitch(),
          SizedBox(width: 8),
        ],
      ),
      body: LoadingOverlay(
        isLoading: _isSubmitting,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_errorMessage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ім\'я',
                      border: OutlineInputBorder(),
                    ),
                    controller: _nameCtrl,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Будь ласка, введіть ім\'я' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Опис',
                      border: OutlineInputBorder(),
                    ),
                    controller: _descriptionCtrl,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedHobby,
                    decoration: const InputDecoration(
                      labelText: 'Хобі',
                      border: OutlineInputBorder(),
                    ),
                    items: _hobbyOptions
                        .map((h) => DropdownMenuItem(
                              value: h,
                              child: Text(h),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedHobby = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Контакти',
                      border: OutlineInputBorder(),
                      hintText: 'email або номер телефону',
                    ),
                    controller: _contactsCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'GitHub Username',
                      border: OutlineInputBorder(),
                      hintText: 'username',
                      prefixText: 'github.com/',
                    ),
                    controller: _githubCtrl,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Зберегти резюме',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Скасувати'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

