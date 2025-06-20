% Nama model
model = 'DCMotor_PID_Model';
new_system(model);
open_system(model);

% Tambahkan blok
add_block('simulink/Sources/Step', [model '/SetPoint'], 'Position', [30, 50, 60, 80]);
add_block('simulink/Math Operations/Sum', [model '/Sum'], 'Position', [100, 50, 120, 80], 'Inputs', '+-');
add_block('simulink/Continuous/PID Controller', [model '/PID'], 'Position', [150, 40, 200, 90]);
add_block('simulink/Math Operations/Gain', [model '/DriverGain'], 'Position', [230, 50, 270, 80], 'Gain', '1');
add_block('simulink/Continuous/Transfer Fcn', [model '/DCMotor'], ...
    'Numerator', '[2]', 'Denominator', '[1 12 20.02]', 'Position', [300, 40, 400, 90]);
add_block('simulink/Sinks/Scope', [model '/Scope'], 'Position', [430, 50, 460, 80]);

% Buat koneksi antar blok
add_line(model, 'SetPoint/1', 'Sum/1');
add_line(model, 'Sum/1', 'PID/1');
add_line(model, 'PID/1', 'DriverGain/1');
add_line(model, 'DriverGain/1', 'DCMotor/1');
add_line(model, 'DCMotor/1', 'Scope/1');
add_line(model, 'DCMotor/1', 'Sum/2');  % Feedback

% Simpan model
save_system(model);

