final RegExp namePattern = RegExp(r'^[a-zA-Z\s]{3,30}$'); // Name: Letters only, 3-30 chars
final RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Email pattern
final RegExp passwordPattern = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'); // Password: At least 8 chars, 1 letter, 1 number

const String placeholderProfileImageUrl = 'https://th.bing.com/th/id/OIP.0TsJGYhWWOy_hBFOH0hX-gHaHa?rs=1&pid=ImgDetMain';