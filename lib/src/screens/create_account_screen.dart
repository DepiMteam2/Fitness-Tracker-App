import 'package:fitness_app/src/constant/constant.dart';
import 'package:fitness_app/src/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _signUpName = TextEditingController();
  final TextEditingController _signUpEmail = TextEditingController();
  final TextEditingController _signUpPassword = TextEditingController();
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Fill the detailes to create new account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomTextField(
                      controller: _signUpName,
                      hintText: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: _signUpEmail,
                      hintText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      controller: _signUpPassword,
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: _isObsecure,
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isObsecure = !_isObsecure;
                          });
                        }, 
                        icon: Icon(
                          _isObsecure ? Icons.visibility_off : Icons.visibility,
                        ),
                        ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 63,
                        child: ElevatedButton.icon(
                          label: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CreateAccountScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constant.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
