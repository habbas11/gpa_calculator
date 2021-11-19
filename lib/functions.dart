double percentGrade(double currentVal) {
  if (currentVal >= 98) return 4.00;

  if (currentVal >= 95) return 3.75;

  if (currentVal >= 90) return 3.50;

  if (currentVal >= 85) return 3.25;

  if (currentVal >= 85) return 3.00;

  if (currentVal >= 75) return 2.75;

  if (currentVal >= 70) return 2.50;

  if (currentVal >= 65) return 2.25;

  if (currentVal >= 60) return 2.00;

  if (currentVal >= 55) return 1.75;

  if (currentVal >= 50) return 1.50;

  return 0.00;
}

String letterGrade(double currentVal) {
  if (currentVal >= 98) return 'A+';

  if (currentVal >= 95) return 'A';

  if (currentVal >= 90) return 'A-';

  if (currentVal >= 85) return 'B+';

  if (currentVal >= 80) return 'B';

  if (currentVal >= 75) return 'B-';

  if (currentVal >= 70) return 'C+';

  if (currentVal >= 65) return 'C';

  if (currentVal >= 60) return 'C-';

  if (currentVal >= 55) return 'D+';

  if (currentVal >= 50) return 'D';

  return 'E/F';
}
