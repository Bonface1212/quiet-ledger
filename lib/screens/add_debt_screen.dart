import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/debt.dart';
import '../providers/debt_provider.dart';

class AddDebtScreen extends ConsumerStatefulWidget {
  const AddDebtScreen({super.key});

  @override
  ConsumerState<AddDebtScreen> createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends ConsumerState<AddDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _itemController = TextEditingController();
  String _type = 'money';
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Debt')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Person Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'money', child: Text('Money')),
                  DropdownMenuItem(value: 'item', child: Text('Item')),
                ],
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 16),
              if (_type == 'money')
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter an amount' : null,
                ),
              if (_type == 'item')
                TextFormField(
                  controller: _itemController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter an item' : null,
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final debt = Debt(
                      personName: _nameController.text,
                      type: _type,
                      amount: _type == 'money'
                          ? double.tryParse(_amountController.text)
                          : null,
                      itemName: _type == 'item' ? _itemController.text : null,
                      dateLent: DateTime.now(),
                      notes: _notesController.text.isEmpty
                          ? null
                          : _notesController.text,
                    );
                    ref.read(debtListProvider.notifier).addDebt(debt);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Debt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
