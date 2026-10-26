% Run the competition model and print a short summary (stop reason, time, final state).
% Usage (project must be open):  run_baseline
mdl = 'parrotMinidroneCompetition';
load_system(mdl);
stopTime = str2double(get_param(mdl,'StopTime'));
fprintf('Configured StopTime: %g s\n', stopTime);

tic;
out = sim(mdl);
wall = toc;

tEnd = out.tout(end);
fprintf('Simulation ended at t = %.2f s (wall time %.1f s)\n', tEnd, wall);
if tEnd >= stopTime - 1e-6
    fprintf('Reason: reached configured StopTime (no early stop)\n');
else
    fprintf('Reason: stopped EARLY by the Stop Simulation flag (landed or crash/geofence)\n');
end

% Logged by the To Workspace block in the Control System
if isfield(out,'estimatedStates') || isprop(out,'estimatedStates')
    es = out.estimatedStates;
elseif evalin('base','exist(''estimatedStates'',''var'')')
    es = evalin('base','estimatedStates');
else
    es = [];
end
if ~isempty(es)
    d = es; if isstruct(es) || isa(es,'timeseries'), d = es.Data; end
    d = squeeze(d);
    disp('Size of estimatedStates:'); disp(size(d));
    disp('Final row of estimatedStates (see estimatorVars / bus definition for column meaning):');
    if size(d,1) > size(d,2), disp(d(end,:)); else, disp(d(:,end)'); end
else
    disp('estimatedStates not found');
end
assignin('base','baselineOut',out);
