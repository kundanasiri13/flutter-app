import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDGET LOFT',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.cyanAccent,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.cyanAccent),
          bodyMedium: TextStyle(color: Colors.greenAccent),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
        ),
      ),
      home: const ExpenseTrackerHomePage(),
    );
  }
}

class ExpenseTrackerHomePage extends StatefulWidget {
  const ExpenseTrackerHomePage({super.key});

  @override
  _ExpenseTrackerHomePageState createState() => _ExpenseTrackerHomePageState();
}

class _ExpenseTrackerHomePageState extends State<ExpenseTrackerHomePage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  double _income = 0.0;
  double _budget = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _incomeController.dispose();
    _budgetController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addExpense() {
    final String description = _descriptionController.text;
    final String amountText = _amountController.text;
    final String category = _categoryController.text;

    if (description.isNotEmpty &&
        amountText.isNotEmpty &&
        category.isNotEmpty) {
      final double? amount = double.tryParse(amountText);
      if (amount != null) {
        setState(() {
          _expenses.add({
            'description': description,
            'amount': amount,
            'category': category,
            'date': DateTime.now(),
          });
        });
        _descriptionController.clear();
        _amountController.clear();
        _categoryController.clear();
      } else {
        _showErrorDialog("Invalid amount.");
      }
    } else {
      _showErrorDialog("All fields are required.");
    }
  }

  void _setIncomeAndBudget() {
    final incomeText = _incomeController.text;
    final budgetText = _budgetController.text;

    final double? income = double.tryParse(incomeText);
    final double? budget = double.tryParse(budgetText);

    if (income != null && income > 0 && budget != null && budget > 0) {
      setState(() {
        _income = income;
        _budget = budget;
      });
      _incomeController.clear();
      _budgetController.clear();
    } else {
      _showErrorDialog(
          "Please enter valid income and budget values greater than zero.");
    }
  }

  double _calculateTotalExpenses() {
    return _expenses.fold(0.0, (sum, item) => sum + item['amount']);
  }

  double _calculateRemainingBalance() {
    if (_budget <= 0) {
      return 0.0;
    }

    double remainingBalance = _budget - _calculateTotalExpenses();
    return remainingBalance;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text("Error", style: TextStyle(color: Colors.redAccent)),
        content: Text(message, style: const TextStyle(color: Colors.cyanAccent)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK", style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(String title, double value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "₹${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 18,
              color: title == "Available Balance" && value < 0
                  ? Colors.redAccent
                  : Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          right: 30,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black), // Background
        _buildBackgroundCircles(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Expense Tracker"),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                const Tab(icon: Icon(Icons.track_changes), text: "Tracker"),
                const Tab(icon: Icon(Icons.pie_chart), text: "Analysis"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildExpenseTrackerTab(),
              _buildAnalysisTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseTrackerTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoBlock("Available Balance", _calculateRemainingBalance()),
            const SizedBox(height: 20),
            const Text(
              "Set Income and Budget",
              style: TextStyle(fontSize: 18, color: Colors.cyanAccent),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _incomeController,
                    decoration: const InputDecoration(labelText: "Monthly Income"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _budgetController,
                    decoration: const InputDecoration(labelText: "Monthly Budget"),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _setIncomeAndBudget,
              child: const Text("Set Income & Budget"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBlock("Income", _income),
                _buildInfoBlock("Expenses", _calculateTotalExpenses()),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              "Add New Expense",
              style: TextStyle(fontSize: 18, color: Colors.cyanAccent),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addExpense,
              child: const Text("Add Expense"),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(expense['description'],
                        style: const TextStyle(color: Colors.cyanAccent)),
                    subtitle: Text(
                      "${expense['date'].toLocal().toString().split(' ')[0]} | ${expense['category']}",
                      style: const TextStyle(color: Colors.greenAccent),
                    ),
                    trailing: Text(
                      "₹${expense['amount'].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAnalysisTab() {
    Map<String, double> monthlyExpenses = {};
    Map<String, double> categoryExpenses = {};

    for (var expense in _expenses) {
      // Monthly Analysis
      DateTime date = expense['date'];
      String month =
          "${date.year}-${date.month.toString().padLeft(2, '0')}"; // format as "yyyy-MM"

      monthlyExpenses[month] =
          (monthlyExpenses[month] ?? 0) + expense['amount'];

      // Category Analysis
      String category = expense['category'];
      categoryExpenses[category] =
          (categoryExpenses[category] ?? 0) + expense['amount'];
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Monthly Expenses",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: monthlyExpenses.length,
              itemBuilder: (context, index) {
                String month = monthlyExpenses.keys.elementAt(index);
                double amount = monthlyExpenses[month]!;
                return Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(month,
                        style: const TextStyle(color: Colors.greenAccent)),
                    trailing: Text("₹${amount.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Category Expenses",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryExpenses.length,
              itemBuilder: (context, index) {
                String category = categoryExpenses.keys.elementAt(index);
                double amount = categoryExpenses[category]!;
                return Card(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(category,
                        style: const TextStyle(color: Colors.greenAccent)),
                    trailing: Text("₹${amount.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}