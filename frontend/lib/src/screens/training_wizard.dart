import 'package:flutter/material.dart';
import 'package:jefit_app/src/theme/app_colors.dart';

class TrainingWizard extends StatefulWidget {
  const TrainingWizard({super.key});

  @override
  State<TrainingWizard> createState() => _TrainingWizardState();
}

class _TrainingWizardState extends State<TrainingWizard> {
  final List<Map<String, dynamic>> ejerciciosSeleccionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: AppColors.cardBg,
        foregroundColor: AppColors.textPrimary,
        title: const Text('Nuevo entrenamiento'),
        actions: [
          TextButton(
            onPressed: ejerciciosSeleccionados.isNotEmpty ? _guardar : null,
            child: Text('Guardar', style: TextStyle(color: AppColors.success)),
          ),
        ],
      ),
      body: ejerciciosSeleccionados.isEmpty
          ? _buildEmptyState()
          : _buildWizardSteps(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.success,
        onPressed: () => _agregarEjercicio(),
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, color: AppColors.textSecondary, size: 48),
          SizedBox(height: 16),
          Text('Presiona + para agregar ejercicios',
              style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildWizardSteps() {
    // Stepper robado de apps de fuerza: Ejercicio → Series → Confirmar
    return ListView.builder(
      itemCount: ejerciciosSeleccionados.length,
      itemBuilder: (context, index) {
        final ej = ejerciciosSeleccionados[index];
        return Card(
          color: AppColors.cardBg,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            title: Text(ej['name'], style: TextStyle(color: AppColors.textPrimary)),
            subtitle: Text('${ej['series'].length} series', style: TextStyle(color: AppColors.textSecondary)),
            children: [
              _buildSetsEditor(ej, index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSetsEditor(Map<String, dynamic> ej, int ejIndex) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: List.generate(ej['series'].length, (setIndex) {
          final set = ej['series'][setIndex];
          return Row(
            children: [
              Expanded(child: Text('Set ${setIndex + 1}', style: TextStyle(color: AppColors.textSecondary))),
              SizedBox(width: 8),
              Expanded(child: _numInput(set['reps'], 'Reps')),
              SizedBox(width: 8),
              Expanded(child: _numInput(set['carga'], 'Kg')),
            ],
          );
        }),
      ),
    );
  }

  Widget _numInput(dynamic valor, String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.primaryBg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      style: TextStyle(color: AppColors.textPrimary),
      keyboardType: TextInputType.number,
    );
  }

  void _agregarEjercicio() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      builder: (context) => Container(
        height: 300,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selecciona ejercicio', style: TextStyle(color: AppColors.textPrimary, fontSize: 18)),
            SizedBox(height: 12),
            TextField(
              style: TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Buscar ejercicio...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _guardar() {
    // TODO: POST a /api/tracking/log
    Navigator.pop(context);
  }
}
