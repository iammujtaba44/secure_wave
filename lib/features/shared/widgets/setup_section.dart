import 'package:flutter/material.dart';

class SetupSection extends StatelessWidget {
  const SetupSection({
    super.key,
    required this.isLoading,
    required this.isSetupComplete,
    required this.onSetup,
  });

  final bool isLoading;
  final bool isSetupComplete;
  final VoidCallback onSetup;

  @override
  Widget build(BuildContext context) {
    final color = isSetupComplete ? Colors.green : Colors.purple;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.shade50,
            color.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSetupComplete ? Icons.check_circle : Icons.settings,
                  color: color.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  isSetupComplete ? 'Setup Complete' : 'Device Setup',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isSetupComplete
                ? 'Your device is now properly configured and secured.'
                : 'Complete the device setup to enable security features and management controls.',
            style: TextStyle(
              fontSize: 14,
              color: color.shade900,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          if (!isSetupComplete)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSetup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Setting up...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Start Setup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
