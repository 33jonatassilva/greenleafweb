import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ImpactPage extends StatefulWidget {
  const ImpactPage({super.key});

  @override
  State<ImpactPage> createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
  DateTimeRange? _selectedDateRange;
  String _selectedFilter = '1 Year';
  final List<String> _filters = ['1 Year', '6 Months', '3 Months', 'Custom'];

  // Dados fictícios de reciclagem
  final List<RecyclingData> _recyclingHistory = [
    RecyclingData(date: DateTime(2023, 1), plastic: 1.5, metal: 1.2, paper: 1.3, glass: 2.1),
    RecyclingData(date: DateTime(2023, 2), plastic: 2.8, metal: 1.4, paper: 1.6, glass: 14.2),
    RecyclingData(date: DateTime(2023, 3), plastic: 2.2, metal: 1.7, paper: 1.4, glass: 13.3),
    RecyclingData(date: DateTime(2023, 4), plastic: 1.6, metal: 1.1, paper: 1.8, glass: 12.5),
    RecyclingData(date: DateTime(2023, 5), plastic: 3.3, metal: 1.9, paper: 2.2, glass: 11.7),
    RecyclingData(date: DateTime(2023, 6), plastic: 2.9, metal: 1.5, paper: 2.4, glass: 10.8),
    RecyclingData(date: DateTime(2023, 7), plastic: 2.4, metal: 1.2, paper: 2.7, glass: 9.3),
    RecyclingData(date: DateTime(2023, 8), plastic: 2.7, metal: 1.6, paper: 2.9, glass: 8.1),
    RecyclingData(date: DateTime(2023, 9), plastic: 2.1, metal: 1.3, paper: 2.5, glass: 7.8),
    RecyclingData(date: DateTime(2023, 10), plastic: 2.9, metal: 1.7, paper: 2.2, glass: 6.4),
    RecyclingData(date: DateTime(2023, 11), plastic: 2.5, metal: 1.8, paper: 2.3, glass: 5.6),
    RecyclingData(date: DateTime(2023, 12), plastic: 3.2, metal: 1.4, paper: 2.7, glass: 4.9),
    RecyclingData(date: DateTime(2024, 1), plastic: 3.8, metal: 1.1, paper: 2.5, glass: 3.2),
    RecyclingData(date: DateTime(2024, 2), plastic: 3.6, metal: 1.7, paper: 2.3, glass: 2.8),
    RecyclingData(date: DateTime(2024, 3), plastic: 3.3, metal: 1.2, paper: 2.6, glass: 1.4),
    RecyclingData(date: DateTime(2024, 4), plastic: 3.7, metal: 8.8, paper: 3.1, glass: 0.5),
    RecyclingData(date: DateTime(2024, 5), plastic: 3.4, metal: 8.3, paper: 3.7, glass: 1.9),
    RecyclingData(date: DateTime(2024, 6), plastic: 1.1, metal: 6.6, paper: 3.2, glass: 2.4),
    RecyclingData(date: DateTime(2024, 7), plastic: 1.8, metal: 6.9, paper: 3.5, glass: 3.7),
    RecyclingData(date: DateTime(2024, 8), plastic: 1.3, metal: 5.2, paper: 3.8, glass: 4.1),
    RecyclingData(date: DateTime(2024, 9), plastic: 1.7, metal: 5.5, paper: 3.3, glass: 5.9),
    RecyclingData(date: DateTime(2024, 10), plastic: 1.2, metal: 5.8, paper: 3.6, glass: 6.4),
    RecyclingData(date: DateTime(2024, 11), plastic: 1.9, metal: 1.1, paper: 1.7, glass: 7.2),
    RecyclingData(date: DateTime(2024, 12), plastic: 1.6, metal: 1.4, paper: 2.3, glass: 8.8),
    RecyclingData(date: DateTime(2024, 12), plastic: 1.6, metal: 1.4, paper: 2.3, glass: 9.8),
    RecyclingData(date: DateTime(2025, 1), plastic: 1.6, metal: 6.4, paper: 1.3, glass: 2.8),
    RecyclingData(date: DateTime(2025, 2), plastic: 10.6, metal: 3.4, paper: 9.3, glass: 4.8),
    RecyclingData(date: DateTime(2025, 3), plastic: 5.6, metal: 4.4, paper: 9.3, glass: 5.8),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDateRange = DateTimeRange(
      start: DateTime(now.year - 1, now.month, now.day),
      end: now,
    );
  }

  // void _showDateRangePicker(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Center(
  //       child: Container(
  //         width: MediaQuery.of(context).size.width * 0.95,
  //         height: MediaQuery.of(context).size.height * 0.65,
  //         margin: const EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.2),
  //               blurRadius: 10,
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Cabeçalho
  //             Container(
  //               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
  //               decoration: BoxDecoration(
  //                 color: Colors.green,
  //                 borderRadius: const BorderRadius.only(
  //                   topLeft: Radius.circular(20),
  //                   topRight: Radius.circular(20),
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Selecione o Período',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     icon: const Icon(Icons.close, color: Colors.white),
  //                     onPressed: () => Navigator.pop(context),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             // Calendário
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                 child: SfDateRangePicker(
  //                   selectionMode: DateRangePickerSelectionMode.range,
  //                   initialSelectedRange: PickerDateRange(
  //                     _selectedDateRange?.start,
  //                     _selectedDateRange?.end,
  //                   ),
  //                   monthViewSettings: const DateRangePickerMonthViewSettings(
  //                     showTrailingAndLeadingDates: true,
  //                     dayFormat: 'EEE',
  //                     numberOfWeeksInView: 6,
  //                   ),
  //                   headerStyle: const DateRangePickerHeaderStyle(
  //                     textAlign: TextAlign.center,
  //                     textStyle: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   monthCellStyle: const DateRangePickerMonthCellStyle(
  //                     textStyle: TextStyle(fontSize: 12),
  //                     todayTextStyle: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.green,
  //                     ),
  //                   ),
  //                   yearCellStyle: const DateRangePickerYearCellStyle(
  //                     textStyle: TextStyle(fontSize: 12),
  //                     todayTextStyle: TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.green,
  //                     ),
  //                   ),
  //                   onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
  //                     if (args.value is PickerDateRange) {
  //                       final range = args.value as PickerDateRange;
  //                       if (range.startDate != null && range.endDate != null) {
  //                         setState(() {
  //                           _selectedDateRange = DateTimeRange(
  //                             start: range.startDate!,
  //                             end: range.endDate!,
  //                           );
  //                           _selectedFilter = 'Custom';
  //                         });
  //                         Navigator.pop(context);
  //                       }
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),

  void _showDateRangePicker(BuildContext context) {
    DateTimeRange? _tempRange = _selectedDateRange;

    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.65,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cabeçalho
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Selecione o Período',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Calendário
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                      _selectedDateRange?.start,
                      _selectedDateRange?.end,
                    ),
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: true,
                      dayFormat: 'EEE',
                      numberOfWeeksInView: 6,
                    ),
                    headerStyle: const DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                      textStyle: TextStyle(fontSize: 12),
                      todayTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    yearCellStyle: const DateRangePickerYearCellStyle(
                      textStyle: TextStyle(fontSize: 12),
                      todayTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is PickerDateRange) {
                        final range = args.value as PickerDateRange;
                        if (range.startDate != null && range.endDate != null) {
                          _tempRange = DateTimeRange(
                            start: range.startDate!,
                            end: range.endDate!,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),

              // Botão de confirmação
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_tempRange != null) {
                      setState(() {
                        _selectedDateRange = _tempRange;
                        _selectedFilter = 'Custom';
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Confirmar Período',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // // Botão de confirmação
  //             Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green,
  //                   minimumSize: const Size(double.infinity, 50),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text(
  //                   'Confirmar Período',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _applyFilter(String filter) {
    final now = DateTime.now();
    setState(() {
      _selectedFilter = filter;
      switch (filter) {
        case '1 Year':
          _selectedDateRange = DateTimeRange(
            start: DateTime(now.year - 1, now.month, now.day),
            end: now,
          );
          break;
        case '6 Months':
          _selectedDateRange = DateTimeRange(
            start: DateTime(now.year, now.month - 6, now.day),
            end: now,
          );
          break;
        case '3 Months':
          _selectedDateRange = DateTimeRange(
            start: DateTime(now.year, now.month - 3, now.day),
            end: now,
          );
          break;
        case 'Custom':
          _showDateRangePicker(context);
          break;
      }
    });
  }

  Map<String, double> _calculateTotals() {
    double plastic = 0;
    double metal = 0;
    double paper = 0;
    double glass = 0;
    int points = 0;

    if (_selectedDateRange != null) {
      for (var data in _recyclingHistory) {
        if (data.date.isAfter(_selectedDateRange!.start.subtract(const Duration(days: 1)))) {
        if (data.date.isBefore(_selectedDateRange!.end.add(const Duration(days: 1)))) {
        plastic += data.plastic;
        metal += data.metal;
        paper += data.paper;
        glass += data.glass;
        points += ((data.plastic + data.metal + data.paper + data.glass) * 10).toInt();
        }
        }
        }
        }

        return {
        'plastic': plastic,
        'metal': metal,
        'paper': paper,
        'glass': glass,
        'points': points.toDouble(),
        };
        }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final formatter = DateFormat('MMM yyyy');
    final totalRecycled = totals['plastic']! + totals['metal']! + totals['paper']! + totals['glass']!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Impact'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro com rolagem horizontal
            const Text('Filter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (selected) => _applyFilter(filter),
                      selectedColor: Colors.green,
                      labelStyle: TextStyle(
                        color: _selectedFilter == filter ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            if (_selectedDateRange != null)
              Text(
                '${formatter.format(_selectedDateRange!.start)} - ${formatter.format(_selectedDateRange!.end)}',
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 20),

            // Card de Pontuação
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '${totals['points']?.toInt()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text('POINTS', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.cloud, color: Colors.white),
                      const Text('SAVED CO2', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        totalRecycled.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text('RECYCLED', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Título "Your Impact"
            const Text('Your Impact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Lista de materiais reciclados
            _buildMaterialCard(
              icon: Icons.local_drink,
              color: Colors.blue,
              material: 'Plastic',
              amount: totals['plastic']!,
              unit: 'kg',
              year: _selectedDateRange?.end.year ?? DateTime.now().year,
            ),
            _buildMaterialCard(
              icon: Icons.build,
              color: Colors.orange,
              material: 'Metal',
              amount: totals['metal']!,
              unit: 'kg',
              year: _selectedDateRange?.end.year ?? DateTime.now().year,
            ),
            _buildMaterialCard(
              icon: Icons.description,
              color: Colors.green,
              material: 'Paper',
              amount: totals['paper']!,
              unit: 'kg',
              year: _selectedDateRange?.end.year ?? DateTime.now().year,
            ),
            _buildMaterialCard(
              icon: Icons.wine_bar,
              color: Colors.teal,
              material: 'Glass',
              amount: totals['glass']!,
              unit: 'kg',
              year: _selectedDateRange?.end.year ?? DateTime.now().year,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard({
    required IconData icon,
    required Color color,
    required String material,
    required double amount,
    required String unit,
    required int year,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${amount.toStringAsFixed(1)} $unit in $year',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Text(
              '${(amount * 10).toInt()} pts',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecyclingData {
  final DateTime date;
  final double plastic;
  final double metal;
  final double paper;
  final double glass;

  RecyclingData({
    required this.date,
    required this.plastic,
    required this.metal,
    required this.paper,
    required this.glass,
  });
}