class MyDuration {
    final int _milliseconds;

    MyDuration.fromHours(int hours)
        : _milliseconds = _validateDuration(hours * 3600 * 1000);

    MyDuration.fromMinutes(int minutes)
        : _milliseconds = _validateDuration(minutes * 60 * 1000); // Fixed

    MyDuration.fromSeconds(int seconds)
        : _milliseconds = _validateDuration(seconds * 1000); // Fixed

    // Validate the duration
    static int _validateDuration(int milliseconds) {
        if (milliseconds < 0) {
        throw ArgumentError('Duration must be greater than or equal to 0.');
        }
        return milliseconds;
    }

    // Overloaded '>' operator
    bool operator >(MyDuration other) {
        return _milliseconds > other._milliseconds;
    }

    // Overloaded '+' operator
    MyDuration operator +(MyDuration other) {
        return MyDuration.fromMilliseconds(_milliseconds + other._milliseconds);
    }

    // Overloaded '-' operator
    MyDuration operator -(MyDuration other) {
        if (_milliseconds < other._milliseconds) {
        throw ArgumentError('Resulting duration cannot be negative.');
        }
        return MyDuration.fromMilliseconds(_milliseconds - other._milliseconds);
    }

    MyDuration.fromMilliseconds(this._milliseconds);

    // Display the duration in a readable format
    @override
    String toString() {
        int seconds = (_milliseconds / 1000).round();
        int minutes = (seconds / 60).floor();
        seconds = seconds % 60;
        int hours = (minutes / 60).floor();
        minutes = minutes % 60;
        return '$hours hours, $minutes minutes, $seconds seconds';
    }
    }

    void main() {
    MyDuration duration1 = MyDuration.fromHours(3); 
    MyDuration duration2 = MyDuration.fromMinutes(45);
    print(duration1 + duration2); 
    print(duration1 > duration2); 

    try {
        print(duration2 - duration1); 
    } catch (e) {
        print(e); 
    }
}
