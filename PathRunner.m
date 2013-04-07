function PathRunner(base_dir , working_dir , function_to_run , display_filename , file_type , varargin)
%Scan folders and do job on each file
%
%syntax: PathRunner(base_dir , working_dir , function_to_run , display_filename , file_type , arg1, arg2, ...)
%example:
%	PathRunner('c:\' , 'input_folder', @my_fun, 1, {*.tif , '*.jpg'}, param1, param2)
%
%	base_dir:			parent directory
%	working_dir:		subfolder for this certain job
%	function_to_run:	the function to use on each file. this function must get dir_info as its 1st parameter
%									example:	function func(file_info , arg1, arg2,...)
%	display_filename:	flag, if to display progress (optional)
%	file_type:			cell structure with the required file types. for example {'*.tif' , '*.jpg'}
%	arg1,...:			additional inputs for function (optional)
%
%	The function gets this file_info:
%		file_info.base_dir
%		file_info.working_dir
%		file_info.sub_dir
%		file_info.full_dir
%		file_info.filename
%		file_info.full_file
%
%
%File created by Yanai Ankri


if nargin<4
	display_filename = false;
end
if nargin<5
	file_type = {'*.tif'};
end
if nargin<6
	varargin = [];
end

if ~isempty(base_dir) && base_dir(end)~='\'
	base_dir = [base_dir '\'];
end
if ~isempty(working_dir) && working_dir(end)~='\'
	working_dir = [working_dir '\'];
end
if ~isempty(working_dir) && working_dir(1)=='\'
	working_dir = working_dir(2:end);
end


%get list of subfolders
path_list = genpath([base_dir , working_dir]);
if isempty(path_list)
	error('working dir not exist')
end

path_counter = 1;
while (1)	%scan target subfolders
	%target files names
	current_folder = strtok(path_list(path_counter:end), pathsep);	% = "c:\base\target path"
	if ~isempty(current_folder) && current_folder(end)~='\'
		current_folder = [current_folder '\'];
		path_counter = path_counter-1;
	end

	list_of_files = [];
	for ft=1:length(file_type)
		list_of_files = [list_of_files dir([current_folder cell2mat(file_type(ft))])];	%file names
	end

	folder_pos = strfind(current_folder , working_dir);
	current_subfolder = current_folder(folder_pos+length(working_dir) : end);

	for file_index = 1:length(list_of_files)	%scan target files in subfolder
		%read target file
		current_filename = list_of_files(file_index).name;
		full_filename = sprintf('%s%s' , current_folder , current_filename);
		if display_filename
			disp(full_filename);
		end

		%prepare info struct
		file_info.base_dir = base_dir;
		file_info.working_dir = working_dir;
		file_info.sub_dir = current_subfolder;
		file_info.full_dir = current_folder;
		file_info.filename = current_filename;
		file_info.full_file = full_filename;
		
		%!!!!!! Do the job !!!!!
		if ~isempty(varargin)
			feval(function_to_run , file_info , varargin);
		else
			feval(function_to_run , file_info);
		end
	end

	%finish targets subfolder
	path_counter = path_counter + length(current_folder) + 1;
	if isempty(strfind(path_list(path_counter:end),';')) , break, end;
end
