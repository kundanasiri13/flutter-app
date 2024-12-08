import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            const Color(0xFFE1F5FE), // Baby Blue Background
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF333333)),
          bodyMedium: TextStyle(color: Color(0xFF555555)),
        ),
        buttonTheme: ButtonThemeData(buttonColor: const Color(0xFF81D4FA)),
      ),
      home: const SignInPage(),
    );
  }
}

// SignInPage
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userIdController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'BUDGET LOFT',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'The idea of saving money with the idea of a lofty goal',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: 'User ID or Email',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Simple validation for empty fields
                  if (userIdController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter both User ID and Password'),
                      ),
                    );
                    return;
                  }

                  // Navigate to Home Screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 85),
                  backgroundColor: const Color(0xFF81D4FA), // Baby Blue Button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10, // More depth
                  shadowColor: Colors.blue.withOpacity(0.4),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: const Color(0xFF81D4FA), // Baby Blue AppBar
        titleTextStyle: const TextStyle(color: Colors.white),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Navigate to Profile Page (can be implemented later)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Lesson Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LessonPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 85),
                backgroundColor: const Color(0xFF81D4FA), // Baby Blue Button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.3),
              ),
              child:
                  const Text('Start Learning', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Implement Expense Tracker functionality here
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 85),
                backgroundColor: const Color(0xFF81D4FA), // Baby Blue Button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.3),
              ),
              child:
                  const Text('Expense Tracker', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

// LessonPage
class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentPage = 0;

  final List<String> pages = [
    'Page 1: Introduction to Financial Literacy\n\nFinancial literacy is the ability to understand and manage your personal finances effectively. It includes the knowledge and skills needed to make informed and effective decisions about budgeting, saving, investing, and borrowing.\nHaving a basic understanding of financial concepts empowers individuals to manage their income, debts, and assets more efficiently, leading to better financial stability and security.\n\nSome essential components of financial literacy include:\nBudgeting – Creating a budget is one of the first steps in managing personal finances. By understanding where your money goes, you can allocate funds to savings and avoid overspending.\nSaving – Setting aside money for emergencies and future needs is key to financial security.',
    'Page 2: Why Financial Literacy Matters\n\nBeing financially literate empowers individuals to take control of their financial situation.It helps you make informed choices about your money, which can lead to better financial stability, less stress, and more opportunities for growth.\n\nWhy financial literacy matters:\nIncreased Control Over Your Money:\n When you understand how to manage your finances, you can make decisions that align with your goals. You’ll be able to budget effectively, save consistently, and avoid unnecessary debt. \nBetter Debt Management: \nFinancially literate individuals are better equipped to manage and reduce debt. They understand the implications of taking on debt, including interest rates, repayment schedules, and long-term consequences',
    'Page 3: The Importance of Budgeting\n\nBudgeting is a fundamental aspect of personal finance management. It involves planning how to allocate your income to various expenses, savings, and investments, ensuring that you can meet your financial goals without overspending.\n By creating a budget, you can prioritize essential expenses such as housing, utilities, and food, while also setting aside funds for discretionary spending and future savings. Budgeting helps you avoid financial stress by keeping track of your spending and ensuring you are not living beyond your means.\n A good budget should be realistic and flexible, allowing you to adjust as necessary while still maintaining control over your finances.The goal is to save and invest regularly while managing day-to-day expenses efficiently.',
    'Page 4: Understanding Debt\n\nDebt can either be helpful or harmful, depending on how you manage it. On one hand, debt allows individuals to make important purchases, such as buying a home or funding an education, when they do not have the full amount of money upfront. On the other hand, accumulating excessive or high-interest debt can lead to financial hardship and stress.\nThere are two main types of debt:\nGood Debt: This is debt that helps you build your financial future. For example, student loans or mortgages can be considered good debt because they can increase your earning potential or provide long-term value.\nBad Debt: This is debt used for non-essential purchases, such as luxury items or unnecessary expenses. Credit card debt with high interest rates is often categorized as bad debt',
    'Page 5: Saving for Emergencies\n\nSaving for unexpected events is a key step in financial planning. Emergencies such as medical bills, car repairs, or job loss can happen at any time, and having an emergency fund can provide a financial safety net when these situations arise. Ideally, your emergency fund should cover three to six months worth of living expenses.\nTo build an emergency fund:\nStart small: Even setting aside a small amount each month can add up over time.\nSet a target: Aim for a specific savings goal, such as 1,000 or enough to cover three months of living expenses.\nKeep it accessible: Store your emergency fund in a high-yield savings account or a money market account to ensure that the funds are easy to access when needed, but still earning interest.',
    'Page 6: Retirement Planning\n\nIt\'s never too early to start planning for retirement. The earlier you begin saving, the more time your money has to grow through the power of compound interest.\nStart saving early: Even small contributions early in your career can grow significantly over time. Take advantage of employer-sponsored retirement plans, like a 401(k)\nContribute regularly: Consistency is key. Contributing regularly, even if it is a small amount, ensures that you are steadily building your retirement fund.\nUnderstand your retirement goals: Estimate how much money you will need to live comfortably in retirement. Consider factors like healthcare, housing, lifestyle, and inflation when planning.\nTake advantage of tax benefits: Many retirement accounts offer tax advantages',
    'Page 7: Investment Basics\n\nInvesting is one of the best ways to grow your wealth. Unlike saving, which typically involves putting money aside in low-risk accounts, investing involves purchasing assets that have the potential to increase in value. By making smart investment choices, you can build a portfolio that generates wealth and supports your long-term financial goals.\n\nHere are some basic principles to understand about investing:\nStart with a plan: Before you begin investing, it is important to assess your financial goals, risk tolerance, and investment horizon.\nRisk and return: Generally, the higher the risk, the higher the potential return. Stocks tend to offer higher returns but come with more volatility.',
    'Page 8: Managing Risk\n\nRisk management is crucial when dealing with investments. Every investment carries some level of risk, whether itis the possibility of losing money or not meeting your financial goals.\n\nHere are some key strategies for managing investment risk:\nDiversification: One of the most effective ways to manage risk is diversification. By spreading your investments across different asset classes,you reduce the impact of any single investment poor performance.\nAsset Allocation: Asset allocation refers to how you distribute your investments among different asset classes based on your risk tolerance, goals, and time horizon.\nRisk Tolerance: Risk tolerance is your ability to endure fluctuations in the value of your investments.',
    'Page 9: Credit Scores and How They Affect You\n\nA good credit score is vital for securing loans and mortgages. It is a numerical representation of your creditworthiness, based on your history of borrowing and repaying money.\n\nWhy is a Credit Score Important?\nLoan Approval: Lenders use credit scores to decide whether to approve or deny loan applications\nInterest Rates: Even if you’re approved for a loan, your credit score will influence the interest rate you’re offered.\nRenting a Home: Landlords may also check your credit score to determine whether you are likely to pay rent on time.\nInsurance Premiums: In some regions, insurers may use your credit score to assess the risk of insuring you. A low score could result in higher premiums for auto or home insurance.',
    'Page 10: Real Estate and Personal Finance\n\nReal estate can be a powerful investment tool if approached wisely. It offers various opportunities for individuals to build wealth, generate passive income, and diversify their investment portfolios\n\nWhy Real Estate Is a Strong Investment:\nTangible Asset:Unlike stocks or bonds, real estate is a physical asset that you can see and touch.\nAppreciation: Real estate generally appreciates in value over time, meaning the property you buy today could be worth much more in the future.\nLeverage: Real estate allows you to use leverage, which means you can control a larger asset with a smaller amount of money.\nRental Income: One of the most appealing aspects of real estate is the potential to generate passive income through rental properties.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Literacy Lessons'),
        backgroundColor: const Color(0xFF81D4FA), // Baby Blue AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                pages[currentPage],
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentPage > 0
                      ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 25),
                    backgroundColor: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Previous', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: currentPage < pages.length - 1
                      ? () {
                          setState(() {
                            currentPage++;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 25),
                    backgroundColor: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
