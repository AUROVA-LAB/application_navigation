%Correct survey in error using google maps

input_filename    = 'trajectory.data';
output_filename_x = 'trajectory_x.csv';
output_filename_y = 'trajectory_y.csv';

%Open rostopic
fileID = fopen(input_filename,'r');
data = textscan(fileID, '%s', 'Delimiter', ' ', 'MultipleDelimsAsOne',1);
fclose(fileID);

%Extracting latitude, longitude and altitude
FIELDS_PER_TOPIC = 121;
x_index = 17;
y_index = 19;
z_index = 28;
w_index = 30;

num_of_topics = length(data{1,1}) / FIELDS_PER_TOPIC;
x_pose = zeros(num_of_topics, 1);
y_pose = zeros(num_of_topics, 1);
z_pose = zeros(num_of_topics, 1);
w_pose = zeros(num_of_topics, 1);


for i = 0 : num_of_topics - 1
    x_pose(1+i,1) = str2double(cell2mat(data{1,1}(x_index + i*FIELDS_PER_TOPIC)));
    y_pose(1+i,1) = str2double(cell2mat(data{1,1}(y_index + i*FIELDS_PER_TOPIC)));
    z_pose(1+i,1) = str2double(cell2mat(data{1,1}(z_index + i*FIELDS_PER_TOPIC)));
    w_pose(1+i,1) = str2double(cell2mat(data{1,1}(w_index + i*FIELDS_PER_TOPIC)));
end

% [yaw, pitch, roll] = quat2angle([0 0 z_pose w_pose]);

%Writing the data
dlmwrite(output_filename_x, x_pose, 'delimiter',',','-append');
dlmwrite(output_filename_y, y_pose,'delimiter',',','-append');
plot(x_pose, y_pose)