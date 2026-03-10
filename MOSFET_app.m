classdef final_mosfet_gui_exported_v67 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        MOSFETCharacterizationandAnalysisToolPanel  matlab.ui.container.Panel
        GridLayout9                    matlab.ui.container.GridLayout
        StatusPanel                    matlab.ui.container.Panel
        GridLayout12                   matlab.ui.container.GridLayout
        TextArea_2                     matlab.ui.control.TextArea
        ActionButtonsPanel             matlab.ui.container.Panel
        GridLayout8                    matlab.ui.container.GridLayout
        ExportOptionDropDown           matlab.ui.control.DropDown
        ExportOptionLabel              matlab.ui.control.Label
        ExportButton                   matlab.ui.control.Button
        ResetButton                    matlab.ui.control.Button
        StopButton                     matlab.ui.control.Button
        RunSweepButton                 matlab.ui.control.Button
        TabGroup                       matlab.ui.container.TabGroup
        OutputCurvesTab                matlab.ui.container.Tab
        GridLayout4                    matlab.ui.container.GridLayout
        UIAxes                         matlab.ui.control.UIAxes
        ModemapTab                     matlab.ui.container.Tab
        GridLayout3                    matlab.ui.container.GridLayout
        UIAxes_2                       matlab.ui.control.UIAxes
        IterationsTab_2                matlab.ui.container.Tab
        GridLayout5                    matlab.ui.container.GridLayout
        UIAxes_3                       matlab.ui.control.UIAxes
        ConvergenceTab                 matlab.ui.container.Tab
        GridLayout6                    matlab.ui.container.GridLayout
        UIAxes_4                       matlab.ui.control.UIAxes
        SummaryTab                     matlab.ui.container.Tab
        GridLayout13                   matlab.ui.container.GridLayout
        TextArea                       matlab.ui.control.TextArea
        ModeControlsPanel              matlab.ui.container.Panel
        GridLayout16                   matlab.ui.container.GridLayout
        VsubOVsubEditField             matlab.ui.control.NumericEditField
        VsubOVsubLabel                 matlab.ui.control.Label
        ModeCriterionDropDown          matlab.ui.control.DropDown
        ModeCriterionDropDownLabel     matlab.ui.control.Label
        ShowModeMapCheckBox            matlab.ui.control.CheckBox
        ShowregionBoundaryCheckBox     matlab.ui.control.CheckBox
        SweepSettingsPanel             matlab.ui.container.Panel
        GridLayout15                   matlab.ui.container.GridLayout
        VsubGSsubEditField             matlab.ui.control.NumericEditField
        VsubGSsubEditFieldLabel        matlab.ui.control.Label
        VsubGSsubmaxEditField          matlab.ui.control.NumericEditField
        VsubGSsubmaxEditFieldLabel     matlab.ui.control.Label
        VsubGSsubvaluesEditFieldLabel  matlab.ui.control.Label
        VsubGSsubvaluesEditField       matlab.ui.control.EditField
        VsubGSsubminEditField          matlab.ui.control.NumericEditField
        VsubGSsubminEditFieldLabel     matlab.ui.control.Label
        VsubDSsubEditField             matlab.ui.control.NumericEditField
        VsubDSsubEditFieldLabel        matlab.ui.control.Label
        VsubDSsubmaxEditField          matlab.ui.control.NumericEditField
        VsubDSsubmaxEditFieldLabel     matlab.ui.control.Label
        VsubDSsubminEditField          matlab.ui.control.NumericEditField
        VsubDSsubminEditFieldLabel     matlab.ui.control.Label
        WarmstartacrossVDSCheckBox     matlab.ui.control.CheckBox
        DropDown                       matlab.ui.control.DropDown
        VsubGSsubSetEditorLabel        matlab.ui.control.Label
        VsubDSsubSweepLabel            matlab.ui.control.Label
        SolverControlsPanel            matlab.ui.container.Panel
        GridLayout10                   matlab.ui.container.GridLayout
        ConvergenceTolerancetolEditField  matlab.ui.control.NumericEditField
        ConvergenceTolerancetolEditFieldLabel  matlab.ui.control.Label
        ClampIsubDsub0Label            matlab.ui.control.Label
        NewtonFiniteDifferenceStepEditField  matlab.ui.control.NumericEditField
        NewtonFiniteDifferenceStepEditFieldLabel  matlab.ui.control.Label
        FixedPointDampingFactorEditField  matlab.ui.control.NumericEditField
        FixedPointDampingFactorEditFieldLabel  matlab.ui.control.Label
        MaximumIterationsmax_itersEditField  matlab.ui.control.NumericEditField
        MaximumIterationsmax_itersEditFieldLabel  matlab.ui.control.Label
        CheckBoxclamp                  matlab.ui.control.CheckBox
        NewtonfallbackifnotconvergedCheckBox  matlab.ui.control.CheckBox
        PrimaryMethodDropDown          matlab.ui.control.DropDown
        SolverMethodLabel              matlab.ui.control.Label
        DeviceParametersPanel          matlab.ui.container.Panel
        GridLayout11                   matlab.ui.container.GridLayout
        ChannelLengthModulationVEditField  matlab.ui.control.NumericEditField
        ChannelLengthModulationVEditFieldLabel  matlab.ui.control.Label
        SourceResistanceRsubssubEditField  matlab.ui.control.NumericEditField
        SourceResistanceRsubssubEditFieldLabel  matlab.ui.control.Label
        ElectronMobilitycmVsEditField  matlab.ui.control.NumericEditField
        ElectronMobilitycmVsEditFieldLabel  matlab.ui.control.Label
        OxideCapacitanceDensityCsuboxsubFmEditField  matlab.ui.control.NumericEditField
        OxideCapacitanceDensityCsuboxsubFmEditFieldLabel  matlab.ui.control.Label
        GeometryRatioWLEditField       matlab.ui.control.NumericEditField
        GeometryRatioWLEditFieldLabel  matlab.ui.control.Label
        ThresholdVoltageVsubthsubVEditField  matlab.ui.control.NumericEditField
        ThresholdVoltageVsubthsubVEditFieldLabel  matlab.ui.control.Label
        EnableCheckBox                 matlab.ui.control.CheckBox
    end

    
    properties (Access = private)
        stop_requested = false
        pause_requested = false
        reset_requested = false
        results
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: RunSweepButton
        function RunSweepButtonPushed2(app, event)

            function results = mosfet_calculator1(app, p, Vgs_set, Vds_sweep)

                results = struct( ...
                    'Id_results', [], ...
                    'Vds_sat', [], ...
                    'Id_sat', [], ...
                    'mode_map', [], ...
                    'Vgs_map', [], ...
                    'Vds_map', [], ...
                    'newton_count', 0, ...
                    'runtime', 0, ...
                    'k_factor', 0, ...
                    'iter_map', [], ...
                    'trace_store', [] );

                % PREALLOCATION
                Id_results = zeros(numel(Vgs_set), numel(Vds_sweep));
                Vds_sat    = zeros(numel(Vgs_set),1);
                Id_sat     = zeros(numel(Vgs_set),1);
                iter_map   = zeros(numel(Vgs_set),numel(Vds_sweep));
                
                trace_store = cell(numel(Vgs_set),numel(Vds_sweep));
                
                newton_count = 0;
                
                total_curves = numel(Vgs_set);
                total_points = numel(Vds_sweep);
                
                tic
                
                % MAIN SWEEP 
                for i = 1:total_curves
                
                    prev_Id = 0;
                    sat_found = false;
                
                    for j = 1:total_points
            
                        while app.pause_requested %stopping and pausing
                            drawnow
                            pause(0.05)
                        end

                        if app.reset_requested
                            return
                        end
                
                        % Warm start logic
                        if p.warm_start
                            Id_init = prev_Id;
                        else
                            Id_init = 0;
                        end
                        % -------------------------------------
                
                        [Id, reg, trace, used_newton, iter_count] = ...
                            solver(Vgs_set(i), Vds_sweep(j), Id_init, p);
                
                        % Store results
                        Id_results(i,j) = Id;
                        trace_store{i,j} = trace;
                        iter_map(i,j) = iter_count;
                
                        if used_newton
                            newton_count = newton_count + 1;
                        end
                
                        % Capture first saturation point
                        if reg == 2 && ~sat_found
                            Vds_sat(i) = Vds_sweep(j);
                            Id_sat(i)  = Id;
                            sat_found = true;
                        end
                
                        % LIVE PROGRESS DISPLAY 
                        progress_text = sprintf([ ...
                            '=== Running Solver ===\n\n' ...
                            'Curve: %d / %d\n' ...
                            'Bias Point Index: %d / %d\n' ...
                            'Current Iteration: %d\n'], ...
                            i, total_curves, ...
                            j, total_points, ...
                            iter_count);
                
                        app.TextArea_2.Value = splitlines(progress_text);
                        drawnow
                        % -------------------------------------------
                
                        % Update previous solution for warm start
                        prev_Id = Id;
                
                    end
                end
                
                runtime = toc;
                
                
                % MODE MAP (analytical, no solver)
            
                Vgs_map = linspace(0, max(Vgs_set), 1000);
                Vds_map = linspace(0, max(Vds_sweep), 1000);
                
                [VDS, VGS] = meshgrid(Vds_map, Vgs_map);
                
                mode_map = zeros(size(VDS));
                
                Vov = VGS - p.Vth;
                
                % Cutoff
                mode_map(Vov <= 0) = 0;
                
                % Linear region
                mode_map((Vov > 0) & (VDS < Vov)) = 1;
                
                % Saturation region
                mode_map((Vov > 0) & (VDS >= Vov)) = 2;
                
                % TRANSCONDUCTANCE FACTOR
                k_factor = (p.mu_n * 1e-4) * p.Cox * p.W_L;
                
                % STORE RESULTS 
                results.Id_results   = Id_results;
                results.Vds_sat      = Vds_sat;
                results.Id_sat       = Id_sat;
                results.mode_map     = mode_map;
                results.Vgs_map      = Vgs_map;
                results.Vds_map      = Vds_map;
                results.newton_count = newton_count;
                results.runtime      = runtime;
                results.k_factor     = k_factor;
                results.iter_map     = iter_map;
                results.trace_store  = trace_store;
            
            end
            
            app.pause_requested = false;
            app.reset_requested = false;

            % disable controls during run
            app.ResetButton.Enable = 'off';
            app.ExportButton.Enable = 'off';
            
            app.StopButton.Enable = 'on';
            app.StopButton.Text = 'Stop';
            
            drawnow;

            % === 1. Collect parameters from UI ===

            p.Vth             = app.ThresholdVoltageVsubthsubVEditField.Value;
            p.mu_n            = app.ElectronMobilitycmVsEditField.Value;
            p.Cox             = app.OxideCapacitanceDensityCsuboxsubFmEditField.Value;
            p.W_L             = app.GeometryRatioWLEditField.Value;
            p.Rs              = app.SourceResistanceRsubssubEditField.Value;
            p.lambda          = app.ChannelLengthModulationVEditField.Value;

            p.alpha           = app.FixedPointDampingFactorEditField.Value;
            p.tol             = app.ConvergenceTolerancetolEditField.Value;
        
            p.delta           = app.NewtonFiniteDifferenceStepEditField.Value;
            p.clamp_id        = app.CheckBoxclamp.Value;
            
            p.newton_fallback = app.NewtonfallbackifnotconvergedCheckBox.Value;

            p.warm_start      = app.WarmstartacrossVDSCheckBox.Value;
            
            method = app.PrimaryMethodDropDown.Value;
            
            if strcmp(method,"Newton")
                p.max_iters = 0;
                p.newton_fallback = true;
            end

            p.max_iters       = app.MaximumIterationsmax_itersEditField.Value;
            p.mode_criterion  = app.ModeCriterionDropDown.Value;
            p.Vov_user        = app.VsubOVsubEditField.Value;

            p.show_boundary   = app.ShowregionBoundaryCheckBox.Value;
            p.show_mode_map   = app.ShowModeMapCheckBox.Value;

            % === 2. Build Vds sweep ===

            Vds_min = app.VsubDSsubminEditField.Value;
            Vds_max = app.VsubDSsubmaxEditField.Value;
            dVds    = app.VsubDSsubEditField.Value;

            Vds_sweep = Vds_min:dVds:Vds_max;

            % === 3. Build Vgs set ===

            if strcmp(app.DropDown.Value, "Enter values")
                Vgs_set = str2num(app.VsubGSsubvaluesEditField.Value);  % must be vector
            else
                Vgs_min = app.VsubGSsubminEditField.Value;
                Vgs_max = app.VsubGSsubmaxEditField.Value;
                dVgs    = app.VsubGSsubEditField.Value;
                Vgs_set = Vgs_min:dVgs:Vgs_max;
            end

            % === 4. Call calculator ===
           
            results = mosfet_calculator1(app, p, Vgs_set, Vds_sweep);
            app.results = results;

            if isempty(results.Id_results)
                return
            end

            % === 5. Plot output curves ===

            cla(app.UIAxes)
            cla(app.UIAxes_2)
            cla(app.UIAxes_3)
            cla(app.UIAxes_4)

            %-------Id vs Vds-------

            cla(app.UIAxes)
            hold(app.UIAxes, 'on')

            for i = 1:length(Vgs_set)
                plot(app.UIAxes, Vds_sweep,...
                    results.Id_results(i,:), 'LineWidth', 1.5,...
                    'DisplayName', sprintf('V_{GS} = %.2f V', Vgs_set(i)));
            end

            legend(app.UIAxes,'show','Location','northwest')

            hold(app.UIAxes, 'off')
            xlabel(app.UIAxes, 'V_{DS} (V)')
            ylabel(app.UIAxes, 'I_D (A)')
            title(app.UIAxes, 'Output Characteristics')
            grid(app.UIAxes, 'on')

            if app.ShowregionBoundaryCheckBox.Value

                hold(app.UIAxes,'on')
            
                k = (p.mu_n * 1e-4) * p.Cox * p.W_L;
            
                % continuous Vgs range
                Vgs_line = linspace(min(Vgs_set), max(Vgs_set), 200);
            
                if strcmp(app.ModeCriterionDropDown.Value,'Internal')
                    Vov = Vgs_line - p.Vth;
                else
                    Vov = p.Vov_user * ones(size(Vgs_line));
                end
            
                % remove invalid points
                valid = Vov > 0;
                Vov = Vov(valid);
            
                % boundary curve
                Vds_boundary = Vov;
                Id_boundary  = 0.5 * k * Vov.^2 .* (1 + p.lambda .* Vds_boundary);

                axColor = app.UIAxes.Color;   % background color of axes

                % Detect dark vs light background
                if mean(axColor) < 0.5
                    boundaryColor = 'w';   % white for dark mode
                else
                    boundaryColor = 'k';   % black for light mode
                end
            
                plot(app.UIAxes, ...
                    Vds_boundary, ...
                    Id_boundary, ...
                    '--', 'Color', boundaryColor, ... 
                    'LineWidth',2,'DisplayName','Sat Boundary');
            
            end
            %-------Mode Map-------

            if p.show_mode_map

                cla(app.UIAxes_2)
            
                imagesc(app.UIAxes_2, ...
                    results.Vds_map, ...
                    results.Vgs_map, ...
                    results.mode_map);
            
                axis(app.UIAxes_2,'xy')
                xlim(app.UIAxes_2,[min(Vds_sweep) max(Vds_sweep)])
                ylim(app.UIAxes_2,[min(Vgs_set) max(Vgs_set)])
            
                colormap(app.UIAxes_2,[0.5 0.5 0.5; 0 0.6 1; 1 0 0])
                clim(app.UIAxes_2,[0 2])

                colormap(app.UIAxes_2,[0.6 0.6 0.6; 0 0.6 1; 1 0 0])

              
                cb = colorbar(app.UIAxes_2);
                cb.Ticks = [0 1 2];
                cb.TickLabels = {'','',''};   % hide long labels

                ylabel(cb,'Cutoff                                             Linear                                             Saturation','Rotation',90)
                clim(app.UIAxes_2,[0 2])
                
            
                xlabel(app.UIAxes_2,'V_{DS} (V)')
                ylabel(app.UIAxes_2,'V_{GS} (V)')
                title(app.UIAxes_2,'MOSFET Region Map')

                hold(app.UIAxes_2,'on')

                Vgs_line = linspace(min(Vgs_set), max(Vgs_set),200);
                Vds_boundary = Vgs_line - p.Vth;
                
                plot(app.UIAxes_2, Vds_boundary, Vgs_line,'w--','LineWidth',2)
                
                hold(app.UIAxes_2,'off')
            
            else
            
                cla(app.UIAxes_2)
            
            end

            %-------Iteration Map-------

            cla(app.UIAxes_3)

            imagesc(app.UIAxes_3, ...
                Vds_sweep, ...
                Vgs_set, ...
                results.iter_map);

            axis(app.UIAxes_3, 'xy', 'tight')
            % xlim(app.UIAxes_3,[min(Vds_sweep) max(Vds_sweep)])
            % ylim(app.UIAxes_3,[min(Vgs_set) max(Vgs_set)])
            colorbar(app.UIAxes_3)

            xlabel(app.UIAxes_3, 'V_{DS} (V)')
            ylabel(app.UIAxes_3, 'V_{GS} (V)')
            title(app.UIAxes_3, 'Iteration Count Map')

           
            %-------Convergence Map-------
            
            [~, idx] = max(results.iter_map(:));
            [i,j] = ind2sub(size(results.iter_map), idx);

            trace = results.trace_store{i,j};

            cla(app.UIAxes_4)
            semilogy(app.UIAxes_4, trace, 'LineWidth', 2)
            grid(app.UIAxes_4, 'on')
            xlabel(app.UIAxes_4, 'Iteration')
            ylabel(app.UIAxes_4, 'Error')
            title(app.UIAxes_4, 'Solver Convergence')


            % ---------- FINAL SUMMARY ----------

            k_value = results.k_factor;

            % Convergence failures
            failure_count = sum(results.iter_map(:) >= p.max_iters);

            % Newton usage
            newton_used = results.newton_count;

            % Runtime
            runtime_val = results.runtime;

            summary_text = sprintf([ ...
                '=== MOSFET Solver Summary ===\n\n' ...
                'Transconductance factor (k): %.4e A/V^2\n\n' ...
                'Total Bias Points: %d\n' ...
                'Convergence Failures: %d\n' ...
                'Newton Fallback Used: %d times\n\n' ...
                'Runtime: %.4f seconds\n'], ...
                k_value, ...
                numel(results.iter_map), ...
                failure_count, ...
                newton_used, ...
                runtime_val);

            app.TextArea.Value = splitlines(summary_text);
            drawnow;

            % re-enable after finish
            app.ResetButton.Enable = 'on';
            app.ExportButton.Enable = 'on';
            app.ExportOptionDropDown.Enable = "on";
            app.ExportOptionLabel.Enable = "on";
            
            app.StopButton.Text = 'Stop';

        end

        % Value changed function: DropDown
        function DropDownValueChanged2(app, event)
            value = app.DropDown.Value;
            
            if contains(value, 'Enter')
                app.VsubGSsubvaluesEditField.Enable = 'on';
                app.VsubGSsubvaluesEditFieldLabel.Enable = 'on';
                app.VsubGSsubEditField.Enable = 'off';
                app.VsubGSsubEditFieldLabel.Enable = 'off';
                app.VsubGSsubmaxEditField.Enable = 'off';
                app.VsubGSsubmaxEditFieldLabel.Enable = 'off';
                app.VsubGSsubminEditField.Enable = 'off';
                app.VsubGSsubminEditFieldLabel.Enable = 'off';
            else
                app.VsubGSsubvaluesEditField.Enable = 'off';
                app.VsubGSsubvaluesEditFieldLabel.Enable = 'off';
                app.VsubGSsubEditField.Enable = 'on';
                app.VsubGSsubEditFieldLabel.Enable = 'on';
                app.VsubGSsubmaxEditField.Enable = 'on';
                app.VsubGSsubmaxEditFieldLabel.Enable = 'on';
                app.VsubGSsubminEditField.Enable = 'on';
                app.VsubGSsubminEditFieldLabel.Enable = 'on';
                
            end
            
        end

        % Value changed function: EnableCheckBox
        function EnableCheckBoxValueChanged(app, event)

            if app.EnableCheckBox.Value
                app.ChannelLengthModulationVEditField.Enable = 'on';
                app.ChannelLengthModulationVEditFieldLabel.Enable = 'on';
            else
                app.ChannelLengthModulationVEditField.Enable = 'off';
                app.ChannelLengthModulationVEditFieldLabel.Enable = 'off';
            end

        end

        % Value changed function: PrimaryMethodDropDown
        function PrimaryMethodDropDownValueChanged2(app, event)
            method = app.PrimaryMethodDropDown.Value;

            if contains(method, 'Fixed')
                app.MaximumIterationsmax_itersEditField.Enable = "on";
                app.MaximumIterationsmax_itersEditFieldLabel.Enable = "on";
                app.FixedPointDampingFactorEditField.Enable = "on";
                app.FixedPointDampingFactorEditFieldLabel.Enable = "on";
                app.FixedPointDampingFactorEditField.Enable = "on";
                app.FixedPointDampingFactorEditFieldLabel.Enable = "on";
                app.NewtonfallbackifnotconvergedCheckBox.Enable = "on";
                app.NewtonFiniteDifferenceStepEditField.Enable = "off";
                app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = "off";
                app.NewtonfallbackifnotconvergedCheckBox.Value = false;
                app.MaximumIterationsmax_itersEditField.Value = 60;

            else
                app.MaximumIterationsmax_itersEditField.Enable = "off";
                app.MaximumIterationsmax_itersEditFieldLabel.Enable = "off";
                app.FixedPointDampingFactorEditField.Enable = "off";
                app.FixedPointDampingFactorEditFieldLabel.Enable = "off";
                app.FixedPointDampingFactorEditField.Enable = "off";
                app.FixedPointDampingFactorEditFieldLabel.Enable = "off";
                app.NewtonfallbackifnotconvergedCheckBox.Enable = "off";
                app.NewtonFiniteDifferenceStepEditField.Enable = "on";
                app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = "on";
                app.NewtonfallbackifnotconvergedCheckBox.Value = true;
                app.MaximumIterationsmax_itersEditField.Value = 0;

            end

        end

        % Value changed function: NewtonfallbackifnotconvergedCheckBox
        function NewtonfallbackifnotconvergedCheckBoxValueChanged(app, event)
            if app.NewtonfallbackifnotconvergedCheckBox.Value
                app.NewtonFiniteDifferenceStepEditField.Enable = 'on';
                app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = 'on';
            else
                app.NewtonFiniteDifferenceStepEditField.Enable = 'off';
                app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = 'off';
            end
    
        end

        % Value changed function: ModeCriterionDropDown
        function ModeCriterionDropDownValueChanged2(app, event)
            mode = app.ModeCriterionDropDown.Value;

            if strcmp(mode,"Internal")
            
                % Vov computed internally
                app.VsubOVsubEditField.Enable = "off";
                app.VsubOVsubLabel.Enable = "off";
                app.VsubOVsubEditField.Value = 0;
            
            else
            
                % User defines Vov
                app.VsubOVsubEditField.Enable = "on";
                app.VsubOVsubLabel.Enable = "on";
            end
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            
            app.reset_requested = true;
            app.pause_requested = false;
            
            app.StopButton.Text = "Stop";

            app.ThresholdVoltageVsubthsubVEditField.Value = 0.7;
            app.ElectronMobilitycmVsEditField.Value = 400;
            app.OxideCapacitanceDensityCsuboxsubFmEditField.Value = 0.0015;
            app.GeometryRatioWLEditField.Value = 10;
            app.SourceResistanceRsubssubEditField.Value = 100;

            app.EnableCheckBox.Value = false;
            app.ChannelLengthModulationVEditField.Enable = "off";
            app.ChannelLengthModulationVEditFieldLabel.Enable = "off";
        
            % Sweep settings
            app.VsubDSsubminEditField.Value = 0;
            app.VsubDSsubEditField.Value = 0.1;
            app.VsubDSsubmaxEditField.Value = 5;
        
            % VGS
            app.DropDown.Value = "Enter values";
            app.VsubGSsubvaluesEditField.Value = "[0.8 1.1 1.2 1.5]";
            app.VsubGSsubvaluesEditField.Enable = 'on';
            app.VsubGSsubEditField.Enable = 'off';
            app.VsubGSsubEditFieldLabel.Enable = 'off';
            app.VsubGSsubmaxEditField.Enable = 'off';
            app.VsubGSsubmaxEditFieldLabel.Enable = 'off';
            app.VsubGSsubminEditField.Enable = 'off';
            app.VsubGSsubminEditFieldLabel.Enable = 'off';
        
            % Solver
            app.PrimaryMethodDropDown.Value = "Fixed Point";
            app.MaximumIterationsmax_itersEditField.Enable = "on";
            app.MaximumIterationsmax_itersEditFieldLabel.Enable = "on";
            app.FixedPointDampingFactorEditField.Enable = "on";
            app.FixedPointDampingFactorEditFieldLabel.Enable = "on";
            app.FixedPointDampingFactorEditField.Enable = "on";
            app.FixedPointDampingFactorEditFieldLabel.Enable = "on";
            app.NewtonfallbackifnotconvergedCheckBox.Enable = "on";
            app.NewtonFiniteDifferenceStepEditField.Enable = "off";
            app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = "off";
            app.NewtonfallbackifnotconvergedCheckBox.Value = false;
            app.MaximumIterationsmax_itersEditField.Value = 60;
            app.FixedPointDampingFactorEditField.Value = 0.5;
            app.ConvergenceTolerancetolEditField.Value = 1e-6;
        
            % Checkboxes
            app.WarmstartacrossVDSCheckBox.Value = true;
            app.ShowregionBoundaryCheckBox.Value = true;
            app.ShowModeMapCheckBox.Value = true;
        
            % Mode
            app.ModeCriterionDropDown.Value = "Internal";
            app.VsubOVsubEditField.Enable = "off";
            app.VsubOVsubLabel.Enable = "off";
        
            % Clear plots
            cla(app.UIAxes)
            cla(app.UIAxes_2)
            cla(app.UIAxes_3)
            cla(app.UIAxes_4)
        
            % Clear status
            app.TextArea_2.Value = "App reset to default values.";

            drawnow
        end

        % Button pushed function: StopButton
        function StopButtonPushed(app, event)
            if app.pause_requested == false

                % pause solver
                app.pause_requested = true;
                app.StopButton.Text = "Resume";
                app.ResetButton.Enable = "on";
                app.TextArea_2.Value = "Solver paused";
        
            else
        
                % resume solver
                app.pause_requested = false;
                app.StopButton.Text = "Stop";
                app.ResetButton.Enable = "off";
                app.TextArea_2.Value = "Solver resumed";
        
            end
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
            
            choice = app.ExportOptionDropDown.Value;

            [file,path] = uiputfile('*.*','Save Export');

            if isequal(file,0)
                return
            end
            
            filename = fullfile(path,file);
            
            % Detect active tab
            tab = app.TabGroup.SelectedTab;
            
            if tab == app.OutputCurvesTab
                ax = app.UIAxes;
            
            elseif tab == app.ModemapTab
                ax = app.UIAxes_2;
            
            elseif tab == app.IterationsTab
                ax = app.UIAxes_3;
            
            elseif tab == app.ConvergenceTab
                ax = app.UIAxes_4;
            
            end
            
            switch choice
            
                case 'PNG'
                    exportgraphics(ax, filename + ".png",'Resolution',300)
            
                case 'PDF'
                    exportgraphics(ax, filename + ".pdf")
            
                case 'MAT'
                    save(filename + ".mat",'app')
            
                case 'CSV'
        
                    if isempty(app.results)
                        uialert(app.UIFigure,"No results available to export.","Export Error")
                        return
                    end
                    
                    writematrix(app.results.Id_results,'Id_results.csv')
            
            end
            
            app.TextArea_2.Value = "Export completed.";

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1408 839];
            app.UIFigure.Name = 'MATLAB App';

            % Create MOSFETCharacterizationandAnalysisToolPanel
            app.MOSFETCharacterizationandAnalysisToolPanel = uipanel(app.UIFigure);
            app.MOSFETCharacterizationandAnalysisToolPanel.TitlePosition = 'centertop';
            app.MOSFETCharacterizationandAnalysisToolPanel.Title = 'MOSFET Characterization and Analysis Tool';
            app.MOSFETCharacterizationandAnalysisToolPanel.FontName = 'SansSerif';
            app.MOSFETCharacterizationandAnalysisToolPanel.FontWeight = 'bold';
            app.MOSFETCharacterizationandAnalysisToolPanel.FontSize = 18;
            app.MOSFETCharacterizationandAnalysisToolPanel.Position = [14 16 1383 808];

            % Create GridLayout9
            app.GridLayout9 = uigridlayout(app.MOSFETCharacterizationandAnalysisToolPanel);
            app.GridLayout9.ColumnWidth = {'1x', '1.5x', '2x', '1x', '1x', '1x', '1x'};
            app.GridLayout9.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '0.5x'};

            % Create DeviceParametersPanel
            app.DeviceParametersPanel = uipanel(app.GridLayout9);
            app.DeviceParametersPanel.Title = '  Device Parameters';
            app.DeviceParametersPanel.Layout.Row = [1 5];
            app.DeviceParametersPanel.Layout.Column = [1 2];
            app.DeviceParametersPanel.FontWeight = 'bold';
            app.DeviceParametersPanel.FontSize = 14;

            % Create GridLayout11
            app.GridLayout11 = uigridlayout(app.DeviceParametersPanel);
            app.GridLayout11.ColumnWidth = {'100x', 53, 36, 38, 110};
            app.GridLayout11.RowHeight = {20, 18, 38, 20, 18, 20, 18, 20, 18, 20, 18, 38};
            app.GridLayout11.ColumnSpacing = 5.20000203450521;
            app.GridLayout11.RowSpacing = 2.40000563401442;
            app.GridLayout11.Padding = [5.20000203450521 2.40000563401442 5.20000203450521 2.40000563401442];

            % Create EnableCheckBox
            app.EnableCheckBox = uicheckbox(app.GridLayout11);
            app.EnableCheckBox.ValueChangedFcn = createCallbackFcn(app, @EnableCheckBoxValueChanged, true);
            app.EnableCheckBox.Text = '  Enable λ';
            app.EnableCheckBox.FontSize = 14;
            app.EnableCheckBox.FontWeight = 'bold';
            app.EnableCheckBox.Layout.Row = 12;
            app.EnableCheckBox.Layout.Column = [1 4];

            % Create ThresholdVoltageVsubthsubVEditFieldLabel
            app.ThresholdVoltageVsubthsubVEditFieldLabel = uilabel(app.GridLayout11);
            app.ThresholdVoltageVsubthsubVEditFieldLabel.FontSize = 14;
            app.ThresholdVoltageVsubthsubVEditFieldLabel.Layout.Row = [1 2];
            app.ThresholdVoltageVsubthsubVEditFieldLabel.Layout.Column = [1 4];
            app.ThresholdVoltageVsubthsubVEditFieldLabel.Interpreter = 'html';
            app.ThresholdVoltageVsubthsubVEditFieldLabel.Text = 'Threshold Voltage (V<sub>th</sub> ) [V]';

            % Create ThresholdVoltageVsubthsubVEditField
            app.ThresholdVoltageVsubthsubVEditField = uieditfield(app.GridLayout11, 'numeric');
            app.ThresholdVoltageVsubthsubVEditField.HorizontalAlignment = 'center';
            app.ThresholdVoltageVsubthsubVEditField.FontSize = 14;
            app.ThresholdVoltageVsubthsubVEditField.Layout.Row = [1 2];
            app.ThresholdVoltageVsubthsubVEditField.Layout.Column = 5;
            app.ThresholdVoltageVsubthsubVEditField.Value = 0.7;

            % Create GeometryRatioWLEditFieldLabel
            app.GeometryRatioWLEditFieldLabel = uilabel(app.GridLayout11);
            app.GeometryRatioWLEditFieldLabel.FontSize = 14;
            app.GeometryRatioWLEditFieldLabel.Layout.Row = [6 7];
            app.GeometryRatioWLEditFieldLabel.Layout.Column = [1 3];
            app.GeometryRatioWLEditFieldLabel.Text = 'Geometry Ratio (W/L)';

            % Create GeometryRatioWLEditField
            app.GeometryRatioWLEditField = uieditfield(app.GridLayout11, 'numeric');
            app.GeometryRatioWLEditField.HorizontalAlignment = 'center';
            app.GeometryRatioWLEditField.FontSize = 14;
            app.GeometryRatioWLEditField.Layout.Row = [6 7];
            app.GeometryRatioWLEditField.Layout.Column = 5;
            app.GeometryRatioWLEditField.Value = 10;

            % Create OxideCapacitanceDensityCsuboxsubFmEditFieldLabel
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel = uilabel(app.GridLayout11);
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel.FontSize = 14;
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel.Layout.Row = [4 5];
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel.Layout.Column = [1 4];
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel.Interpreter = 'html';
            app.OxideCapacitanceDensityCsuboxsubFmEditFieldLabel.Text = 'Oxide Capacitance Density (C<sub>ox</sub> ) [F/m²]';

            % Create OxideCapacitanceDensityCsuboxsubFmEditField
            app.OxideCapacitanceDensityCsuboxsubFmEditField = uieditfield(app.GridLayout11, 'numeric');
            app.OxideCapacitanceDensityCsuboxsubFmEditField.HorizontalAlignment = 'center';
            app.OxideCapacitanceDensityCsuboxsubFmEditField.FontSize = 14;
            app.OxideCapacitanceDensityCsuboxsubFmEditField.Layout.Row = [4 5];
            app.OxideCapacitanceDensityCsuboxsubFmEditField.Layout.Column = 5;
            app.OxideCapacitanceDensityCsuboxsubFmEditField.Value = 0.0015;

            % Create ElectronMobilitycmVsEditFieldLabel
            app.ElectronMobilitycmVsEditFieldLabel = uilabel(app.GridLayout11);
            app.ElectronMobilitycmVsEditFieldLabel.FontSize = 14;
            app.ElectronMobilitycmVsEditFieldLabel.Layout.Row = 3;
            app.ElectronMobilitycmVsEditFieldLabel.Layout.Column = [1 4];
            app.ElectronMobilitycmVsEditFieldLabel.Text = 'Electron Mobility (μₙ) [cm²/V·s]';

            % Create ElectronMobilitycmVsEditField
            app.ElectronMobilitycmVsEditField = uieditfield(app.GridLayout11, 'numeric');
            app.ElectronMobilitycmVsEditField.HorizontalAlignment = 'center';
            app.ElectronMobilitycmVsEditField.FontSize = 14;
            app.ElectronMobilitycmVsEditField.Layout.Row = 3;
            app.ElectronMobilitycmVsEditField.Layout.Column = 5;
            app.ElectronMobilitycmVsEditField.Value = 400;

            % Create SourceResistanceRsubssubEditFieldLabel
            app.SourceResistanceRsubssubEditFieldLabel = uilabel(app.GridLayout11);
            app.SourceResistanceRsubssubEditFieldLabel.FontSize = 14;
            app.SourceResistanceRsubssubEditFieldLabel.Layout.Row = [8 9];
            app.SourceResistanceRsubssubEditFieldLabel.Layout.Column = [1 2];
            app.SourceResistanceRsubssubEditFieldLabel.Interpreter = 'html';
            app.SourceResistanceRsubssubEditFieldLabel.Text = 'Source Resistance (R<sub>s</sub> ) [Ω]';

            % Create SourceResistanceRsubssubEditField
            app.SourceResistanceRsubssubEditField = uieditfield(app.GridLayout11, 'numeric');
            app.SourceResistanceRsubssubEditField.HorizontalAlignment = 'center';
            app.SourceResistanceRsubssubEditField.FontSize = 14;
            app.SourceResistanceRsubssubEditField.Layout.Row = [8 9];
            app.SourceResistanceRsubssubEditField.Layout.Column = 5;
            app.SourceResistanceRsubssubEditField.Value = 100;

            % Create ChannelLengthModulationVEditFieldLabel
            app.ChannelLengthModulationVEditFieldLabel = uilabel(app.GridLayout11);
            app.ChannelLengthModulationVEditFieldLabel.FontSize = 14;
            app.ChannelLengthModulationVEditFieldLabel.Enable = 'off';
            app.ChannelLengthModulationVEditFieldLabel.Layout.Row = [10 11];
            app.ChannelLengthModulationVEditFieldLabel.Layout.Column = [1 4];
            app.ChannelLengthModulationVEditFieldLabel.Text = 'Channel-Length Modulation (λ) [V⁻¹]';

            % Create ChannelLengthModulationVEditField
            app.ChannelLengthModulationVEditField = uieditfield(app.GridLayout11, 'numeric');
            app.ChannelLengthModulationVEditField.Limits = [0 1];
            app.ChannelLengthModulationVEditField.HorizontalAlignment = 'center';
            app.ChannelLengthModulationVEditField.FontSize = 14;
            app.ChannelLengthModulationVEditField.Enable = 'off';
            app.ChannelLengthModulationVEditField.Layout.Row = [10 11];
            app.ChannelLengthModulationVEditField.Layout.Column = 5;
            app.ChannelLengthModulationVEditField.Value = 0.2;

            % Create SolverControlsPanel
            app.SolverControlsPanel = uipanel(app.GridLayout9);
            app.SolverControlsPanel.Title = '  Solver Controls';
            app.SolverControlsPanel.Layout.Row = [6 10];
            app.SolverControlsPanel.Layout.Column = [1 2];
            app.SolverControlsPanel.FontWeight = 'bold';
            app.SolverControlsPanel.FontSize = 14;

            % Create GridLayout10
            app.GridLayout10 = uigridlayout(app.SolverControlsPanel);
            app.GridLayout10.ColumnWidth = {25, '1.5x', '1.5x', 116};
            app.GridLayout10.RowHeight = {30, 38, 38, 38, 38, 38, 38};
            app.GridLayout10.ColumnSpacing = 3.85;
            app.GridLayout10.RowSpacing = 4.33125305175781;
            app.GridLayout10.Padding = [3.85 4.33125305175781 3.85 4.33125305175781];

            % Create SolverMethodLabel
            app.SolverMethodLabel = uilabel(app.GridLayout10);
            app.SolverMethodLabel.FontSize = 14;
            app.SolverMethodLabel.FontWeight = 'bold';
            app.SolverMethodLabel.Layout.Row = 1;
            app.SolverMethodLabel.Layout.Column = [1 3];
            app.SolverMethodLabel.Interpreter = 'html';
            app.SolverMethodLabel.Text = 'Solver Method';

            % Create PrimaryMethodDropDown
            app.PrimaryMethodDropDown = uidropdown(app.GridLayout10);
            app.PrimaryMethodDropDown.Items = {'Fixed Point', 'Newton Fallback'};
            app.PrimaryMethodDropDown.ValueChangedFcn = createCallbackFcn(app, @PrimaryMethodDropDownValueChanged2, true);
            app.PrimaryMethodDropDown.FontSize = 14;
            app.PrimaryMethodDropDown.FontWeight = 'bold';
            app.PrimaryMethodDropDown.Layout.Row = 1;
            app.PrimaryMethodDropDown.Layout.Column = [3 4];
            app.PrimaryMethodDropDown.Value = 'Fixed Point';

            % Create NewtonfallbackifnotconvergedCheckBox
            app.NewtonfallbackifnotconvergedCheckBox = uicheckbox(app.GridLayout10);
            app.NewtonfallbackifnotconvergedCheckBox.ValueChangedFcn = createCallbackFcn(app, @NewtonfallbackifnotconvergedCheckBoxValueChanged, true);
            app.NewtonfallbackifnotconvergedCheckBox.Text = '  Newton fallback if not converged';
            app.NewtonfallbackifnotconvergedCheckBox.FontSize = 14;
            app.NewtonfallbackifnotconvergedCheckBox.FontWeight = 'bold';
            app.NewtonfallbackifnotconvergedCheckBox.Layout.Row = 4;
            app.NewtonfallbackifnotconvergedCheckBox.Layout.Column = [1 4];

            % Create CheckBoxclamp
            app.CheckBoxclamp = uicheckbox(app.GridLayout10);
            app.CheckBoxclamp.Text = '';
            app.CheckBoxclamp.FontSize = 14;
            app.CheckBoxclamp.FontWeight = 'bold';
            app.CheckBoxclamp.Layout.Row = 7;
            app.CheckBoxclamp.Layout.Column = [1 3];
            app.CheckBoxclamp.Value = true;

            % Create MaximumIterationsmax_itersEditFieldLabel
            app.MaximumIterationsmax_itersEditFieldLabel = uilabel(app.GridLayout10);
            app.MaximumIterationsmax_itersEditFieldLabel.FontSize = 14;
            app.MaximumIterationsmax_itersEditFieldLabel.Layout.Row = 2;
            app.MaximumIterationsmax_itersEditFieldLabel.Layout.Column = [1 3];
            app.MaximumIterationsmax_itersEditFieldLabel.Interpreter = 'html';
            app.MaximumIterationsmax_itersEditFieldLabel.Text = 'Maximum Iterations (max_iters)';

            % Create MaximumIterationsmax_itersEditField
            app.MaximumIterationsmax_itersEditField = uieditfield(app.GridLayout10, 'numeric');
            app.MaximumIterationsmax_itersEditField.Limits = [0 Inf];
            app.MaximumIterationsmax_itersEditField.HorizontalAlignment = 'center';
            app.MaximumIterationsmax_itersEditField.FontSize = 14;
            app.MaximumIterationsmax_itersEditField.Layout.Row = 2;
            app.MaximumIterationsmax_itersEditField.Layout.Column = 4;
            app.MaximumIterationsmax_itersEditField.Value = 60;

            % Create FixedPointDampingFactorEditFieldLabel
            app.FixedPointDampingFactorEditFieldLabel = uilabel(app.GridLayout10);
            app.FixedPointDampingFactorEditFieldLabel.FontSize = 14;
            app.FixedPointDampingFactorEditFieldLabel.Layout.Row = 3;
            app.FixedPointDampingFactorEditFieldLabel.Layout.Column = [1 3];
            app.FixedPointDampingFactorEditFieldLabel.Interpreter = 'html';
            app.FixedPointDampingFactorEditFieldLabel.Text = 'Fixed-Point Damping Factor (α)';

            % Create FixedPointDampingFactorEditField
            app.FixedPointDampingFactorEditField = uieditfield(app.GridLayout10, 'numeric');
            app.FixedPointDampingFactorEditField.Limits = [0 1];
            app.FixedPointDampingFactorEditField.HorizontalAlignment = 'center';
            app.FixedPointDampingFactorEditField.FontSize = 14;
            app.FixedPointDampingFactorEditField.Layout.Row = 3;
            app.FixedPointDampingFactorEditField.Layout.Column = 4;
            app.FixedPointDampingFactorEditField.Value = 0.5;

            % Create NewtonFiniteDifferenceStepEditFieldLabel
            app.NewtonFiniteDifferenceStepEditFieldLabel = uilabel(app.GridLayout10);
            app.NewtonFiniteDifferenceStepEditFieldLabel.FontSize = 14;
            app.NewtonFiniteDifferenceStepEditFieldLabel.Enable = 'off';
            app.NewtonFiniteDifferenceStepEditFieldLabel.Layout.Row = 5;
            app.NewtonFiniteDifferenceStepEditFieldLabel.Layout.Column = [1 3];
            app.NewtonFiniteDifferenceStepEditFieldLabel.Interpreter = 'html';
            app.NewtonFiniteDifferenceStepEditFieldLabel.Text = 'Newton Finite-Difference Step (δ) ';

            % Create NewtonFiniteDifferenceStepEditField
            app.NewtonFiniteDifferenceStepEditField = uieditfield(app.GridLayout10, 'numeric');
            app.NewtonFiniteDifferenceStepEditField.HorizontalAlignment = 'center';
            app.NewtonFiniteDifferenceStepEditField.FontSize = 14;
            app.NewtonFiniteDifferenceStepEditField.Enable = 'off';
            app.NewtonFiniteDifferenceStepEditField.Layout.Row = 5;
            app.NewtonFiniteDifferenceStepEditField.Layout.Column = 4;
            app.NewtonFiniteDifferenceStepEditField.Value = 1e-09;

            % Create ClampIsubDsub0Label
            app.ClampIsubDsub0Label = uilabel(app.GridLayout10);
            app.ClampIsubDsub0Label.FontSize = 14;
            app.ClampIsubDsub0Label.FontWeight = 'bold';
            app.ClampIsubDsub0Label.Layout.Row = 7;
            app.ClampIsubDsub0Label.Layout.Column = [2 3];
            app.ClampIsubDsub0Label.Interpreter = 'html';
            app.ClampIsubDsub0Label.Text = 'Clamp I<sub>D</sub> ≥ 0';

            % Create ConvergenceTolerancetolEditFieldLabel
            app.ConvergenceTolerancetolEditFieldLabel = uilabel(app.GridLayout10);
            app.ConvergenceTolerancetolEditFieldLabel.FontSize = 14;
            app.ConvergenceTolerancetolEditFieldLabel.Layout.Row = 6;
            app.ConvergenceTolerancetolEditFieldLabel.Layout.Column = [1 3];
            app.ConvergenceTolerancetolEditFieldLabel.Interpreter = 'html';
            app.ConvergenceTolerancetolEditFieldLabel.Text = 'Convergence Tolerance (tol)';

            % Create ConvergenceTolerancetolEditField
            app.ConvergenceTolerancetolEditField = uieditfield(app.GridLayout10, 'numeric');
            app.ConvergenceTolerancetolEditField.HorizontalAlignment = 'center';
            app.ConvergenceTolerancetolEditField.FontSize = 14;
            app.ConvergenceTolerancetolEditField.Layout.Row = 6;
            app.ConvergenceTolerancetolEditField.Layout.Column = 4;
            app.ConvergenceTolerancetolEditField.Value = 1e-06;

            % Create SweepSettingsPanel
            app.SweepSettingsPanel = uipanel(app.GridLayout9);
            app.SweepSettingsPanel.Title = '  Sweep Settings';
            app.SweepSettingsPanel.Layout.Row = [1 7];
            app.SweepSettingsPanel.Layout.Column = 3;
            app.SweepSettingsPanel.FontWeight = 'bold';
            app.SweepSettingsPanel.FontSize = 14;

            % Create GridLayout15
            app.GridLayout15 = uigridlayout(app.SweepSettingsPanel);
            app.GridLayout15.ColumnWidth = {78, 50, 89, '1x'};
            app.GridLayout15.RowHeight = {20, 40, 40, 40, 22, 22, 35, 35, 35, 35, 37};
            app.GridLayout15.RowSpacing = 6.41666412353516;
            app.GridLayout15.Padding = [10 6.41666412353516 10 6.41666412353516];

            % Create VsubDSsubSweepLabel
            app.VsubDSsubSweepLabel = uilabel(app.GridLayout15);
            app.VsubDSsubSweepLabel.FontSize = 14;
            app.VsubDSsubSweepLabel.FontWeight = 'bold';
            app.VsubDSsubSweepLabel.Layout.Row = 1;
            app.VsubDSsubSweepLabel.Layout.Column = 1;
            app.VsubDSsubSweepLabel.Interpreter = 'html';
            app.VsubDSsubSweepLabel.Text = 'V<sub>DS</sub> Sweep';

            % Create VsubGSsubSetEditorLabel
            app.VsubGSsubSetEditorLabel = uilabel(app.GridLayout15);
            app.VsubGSsubSetEditorLabel.FontSize = 14;
            app.VsubGSsubSetEditorLabel.FontWeight = 'bold';
            app.VsubGSsubSetEditorLabel.Layout.Row = 5;
            app.VsubGSsubSetEditorLabel.Layout.Column = [1 2];
            app.VsubGSsubSetEditorLabel.Interpreter = 'html';
            app.VsubGSsubSetEditorLabel.Text = 'V<sub>GS</sub> Set Editor';

            % Create DropDown
            app.DropDown = uidropdown(app.GridLayout15);
            app.DropDown.Items = {'Enter values', 'Generate Range'};
            app.DropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged2, true);
            app.DropDown.FontSize = 14;
            app.DropDown.FontWeight = 'bold';
            app.DropDown.Layout.Row = 6;
            app.DropDown.Layout.Column = [1 4];
            app.DropDown.Value = 'Enter values';

            % Create WarmstartacrossVDSCheckBox
            app.WarmstartacrossVDSCheckBox = uicheckbox(app.GridLayout15);
            app.WarmstartacrossVDSCheckBox.Text = '  Warm-start  across VDS';
            app.WarmstartacrossVDSCheckBox.FontSize = 14;
            app.WarmstartacrossVDSCheckBox.FontWeight = 'bold';
            app.WarmstartacrossVDSCheckBox.Layout.Row = 11;
            app.WarmstartacrossVDSCheckBox.Layout.Column = [1 3];
            app.WarmstartacrossVDSCheckBox.Value = true;

            % Create VsubDSsubminEditFieldLabel
            app.VsubDSsubminEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubDSsubminEditFieldLabel.FontSize = 14;
            app.VsubDSsubminEditFieldLabel.Layout.Row = 2;
            app.VsubDSsubminEditFieldLabel.Layout.Column = 1;
            app.VsubDSsubminEditFieldLabel.Interpreter = 'html';
            app.VsubDSsubminEditFieldLabel.Text = 'V<sub>DS</sub> min';

            % Create VsubDSsubminEditField
            app.VsubDSsubminEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubDSsubminEditField.HorizontalAlignment = 'center';
            app.VsubDSsubminEditField.FontSize = 14;
            app.VsubDSsubminEditField.Layout.Row = 2;
            app.VsubDSsubminEditField.Layout.Column = [3 4];

            % Create VsubDSsubmaxEditFieldLabel
            app.VsubDSsubmaxEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubDSsubmaxEditFieldLabel.FontSize = 14;
            app.VsubDSsubmaxEditFieldLabel.Layout.Row = 4;
            app.VsubDSsubmaxEditFieldLabel.Layout.Column = 1;
            app.VsubDSsubmaxEditFieldLabel.Interpreter = 'html';
            app.VsubDSsubmaxEditFieldLabel.Text = 'V<sub>DS</sub> max';

            % Create VsubDSsubmaxEditField
            app.VsubDSsubmaxEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubDSsubmaxEditField.HorizontalAlignment = 'center';
            app.VsubDSsubmaxEditField.FontSize = 14;
            app.VsubDSsubmaxEditField.Layout.Row = 4;
            app.VsubDSsubmaxEditField.Layout.Column = [3 4];
            app.VsubDSsubmaxEditField.Value = 5;

            % Create VsubDSsubEditFieldLabel
            app.VsubDSsubEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubDSsubEditFieldLabel.FontSize = 14;
            app.VsubDSsubEditFieldLabel.Layout.Row = 3;
            app.VsubDSsubEditFieldLabel.Layout.Column = 1;
            app.VsubDSsubEditFieldLabel.Interpreter = 'html';
            app.VsubDSsubEditFieldLabel.Text = '&#916 V<sub>DS</sub>';

            % Create VsubDSsubEditField
            app.VsubDSsubEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubDSsubEditField.HorizontalAlignment = 'center';
            app.VsubDSsubEditField.FontSize = 14;
            app.VsubDSsubEditField.Layout.Row = 3;
            app.VsubDSsubEditField.Layout.Column = [3 4];
            app.VsubDSsubEditField.Value = 0.1;

            % Create VsubGSsubminEditFieldLabel
            app.VsubGSsubminEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubGSsubminEditFieldLabel.FontSize = 14;
            app.VsubGSsubminEditFieldLabel.Enable = 'off';
            app.VsubGSsubminEditFieldLabel.Layout.Row = 8;
            app.VsubGSsubminEditFieldLabel.Layout.Column = 1;
            app.VsubGSsubminEditFieldLabel.Interpreter = 'html';
            app.VsubGSsubminEditFieldLabel.Text = 'V<sub>GS</sub> min';

            % Create VsubGSsubminEditField
            app.VsubGSsubminEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubGSsubminEditField.HorizontalAlignment = 'center';
            app.VsubGSsubminEditField.FontSize = 14;
            app.VsubGSsubminEditField.Enable = 'off';
            app.VsubGSsubminEditField.Layout.Row = 8;
            app.VsubGSsubminEditField.Layout.Column = [3 4];
            app.VsubGSsubminEditField.Value = 1;

            % Create VsubGSsubvaluesEditField
            app.VsubGSsubvaluesEditField = uieditfield(app.GridLayout15, 'text');
            app.VsubGSsubvaluesEditField.HorizontalAlignment = 'center';
            app.VsubGSsubvaluesEditField.FontSize = 14;
            app.VsubGSsubvaluesEditField.Layout.Row = 7;
            app.VsubGSsubvaluesEditField.Layout.Column = [3 4];
            app.VsubGSsubvaluesEditField.Value = '[0.8 1 1.2 1.5]';

            % Create VsubGSsubvaluesEditFieldLabel
            app.VsubGSsubvaluesEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubGSsubvaluesEditFieldLabel.FontSize = 14;
            app.VsubGSsubvaluesEditFieldLabel.Layout.Row = 7;
            app.VsubGSsubvaluesEditFieldLabel.Layout.Column = 1;
            app.VsubGSsubvaluesEditFieldLabel.Interpreter = 'html';
            app.VsubGSsubvaluesEditFieldLabel.Text = 'V<sub>GS</sub> values';

            % Create VsubGSsubmaxEditFieldLabel
            app.VsubGSsubmaxEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubGSsubmaxEditFieldLabel.FontSize = 14;
            app.VsubGSsubmaxEditFieldLabel.Enable = 'off';
            app.VsubGSsubmaxEditFieldLabel.Layout.Row = 10;
            app.VsubGSsubmaxEditFieldLabel.Layout.Column = 1;
            app.VsubGSsubmaxEditFieldLabel.Interpreter = 'html';
            app.VsubGSsubmaxEditFieldLabel.Text = 'V<sub>GS</sub> max';

            % Create VsubGSsubmaxEditField
            app.VsubGSsubmaxEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubGSsubmaxEditField.HorizontalAlignment = 'center';
            app.VsubGSsubmaxEditField.FontSize = 14;
            app.VsubGSsubmaxEditField.Enable = 'off';
            app.VsubGSsubmaxEditField.Layout.Row = 10;
            app.VsubGSsubmaxEditField.Layout.Column = [3 4];
            app.VsubGSsubmaxEditField.Value = 3;

            % Create VsubGSsubEditFieldLabel
            app.VsubGSsubEditFieldLabel = uilabel(app.GridLayout15);
            app.VsubGSsubEditFieldLabel.FontSize = 14;
            app.VsubGSsubEditFieldLabel.Enable = 'off';
            app.VsubGSsubEditFieldLabel.Layout.Row = 9;
            app.VsubGSsubEditFieldLabel.Layout.Column = 1;
            app.VsubGSsubEditFieldLabel.Interpreter = 'html';
            app.VsubGSsubEditFieldLabel.Text = '&#916 V<sub>GS</sub>';

            % Create VsubGSsubEditField
            app.VsubGSsubEditField = uieditfield(app.GridLayout15, 'numeric');
            app.VsubGSsubEditField.HorizontalAlignment = 'center';
            app.VsubGSsubEditField.FontSize = 14;
            app.VsubGSsubEditField.Enable = 'off';
            app.VsubGSsubEditField.Layout.Row = 9;
            app.VsubGSsubEditField.Layout.Column = [3 4];
            app.VsubGSsubEditField.Value = 0.5;

            % Create ModeControlsPanel
            app.ModeControlsPanel = uipanel(app.GridLayout9);
            app.ModeControlsPanel.Title = '  Mode Controls';
            app.ModeControlsPanel.Layout.Row = [8 10];
            app.ModeControlsPanel.Layout.Column = 3;
            app.ModeControlsPanel.FontWeight = 'bold';
            app.ModeControlsPanel.FontSize = 14;

            % Create GridLayout16
            app.GridLayout16 = uigridlayout(app.ModeControlsPanel);
            app.GridLayout16.ColumnWidth = {2, 71, 72, 57, '1x'};
            app.GridLayout16.RowHeight = {25, 38, 33, 33};
            app.GridLayout16.ColumnSpacing = 3.38333129882812;
            app.GridLayout16.RowSpacing = 7.560009765625;
            app.GridLayout16.Padding = [3.38333129882812 7.560009765625 3.38333129882812 7.560009765625];

            % Create ShowregionBoundaryCheckBox
            app.ShowregionBoundaryCheckBox = uicheckbox(app.GridLayout16);
            app.ShowregionBoundaryCheckBox.Text = '  Show region Boundary';
            app.ShowregionBoundaryCheckBox.FontSize = 14;
            app.ShowregionBoundaryCheckBox.FontWeight = 'bold';
            app.ShowregionBoundaryCheckBox.Layout.Row = 3;
            app.ShowregionBoundaryCheckBox.Layout.Column = [2 4];
            app.ShowregionBoundaryCheckBox.Value = true;

            % Create ShowModeMapCheckBox
            app.ShowModeMapCheckBox = uicheckbox(app.GridLayout16);
            app.ShowModeMapCheckBox.Text = '  Show Mode Map';
            app.ShowModeMapCheckBox.FontSize = 14;
            app.ShowModeMapCheckBox.FontWeight = 'bold';
            app.ShowModeMapCheckBox.Layout.Row = 4;
            app.ShowModeMapCheckBox.Layout.Column = [2 4];
            app.ShowModeMapCheckBox.Value = true;

            % Create ModeCriterionDropDownLabel
            app.ModeCriterionDropDownLabel = uilabel(app.GridLayout16);
            app.ModeCriterionDropDownLabel.FontSize = 14;
            app.ModeCriterionDropDownLabel.FontWeight = 'bold';
            app.ModeCriterionDropDownLabel.Layout.Row = 1;
            app.ModeCriterionDropDownLabel.Layout.Column = [2 3];
            app.ModeCriterionDropDownLabel.Text = 'Mode Criterion';

            % Create ModeCriterionDropDown
            app.ModeCriterionDropDown = uidropdown(app.GridLayout16);
            app.ModeCriterionDropDown.Items = {'Internal', 'External'};
            app.ModeCriterionDropDown.ValueChangedFcn = createCallbackFcn(app, @ModeCriterionDropDownValueChanged2, true);
            app.ModeCriterionDropDown.FontSize = 14;
            app.ModeCriterionDropDown.FontWeight = 'bold';
            app.ModeCriterionDropDown.Layout.Row = 1;
            app.ModeCriterionDropDown.Layout.Column = [4 5];
            app.ModeCriterionDropDown.Value = 'Internal';

            % Create VsubOVsubLabel
            app.VsubOVsubLabel = uilabel(app.GridLayout16);
            app.VsubOVsubLabel.FontSize = 14;
            app.VsubOVsubLabel.Enable = 'off';
            app.VsubOVsubLabel.Layout.Row = 2;
            app.VsubOVsubLabel.Layout.Column = 2;
            app.VsubOVsubLabel.Interpreter = 'html';
            app.VsubOVsubLabel.Text = '  V<sub>OV</sub>';

            % Create VsubOVsubEditField
            app.VsubOVsubEditField = uieditfield(app.GridLayout16, 'numeric');
            app.VsubOVsubEditField.HorizontalAlignment = 'center';
            app.VsubOVsubEditField.FontSize = 14;
            app.VsubOVsubEditField.Enable = 'off';
            app.VsubOVsubEditField.Layout.Row = 2;
            app.VsubOVsubEditField.Layout.Column = [4 5];

            % Create TabGroup
            app.TabGroup = uitabgroup(app.GridLayout9);
            app.TabGroup.Layout.Row = [1 9];
            app.TabGroup.Layout.Column = [4 7];

            % Create OutputCurvesTab
            app.OutputCurvesTab = uitab(app.TabGroup);
            app.OutputCurvesTab.Title = 'Output Curves';

            % Create GridLayout4
            app.GridLayout4 = uigridlayout(app.OutputCurvesTab);
            app.GridLayout4.ColumnWidth = {'15.79x'};
            app.GridLayout4.RowHeight = {'1x'};
            app.GridLayout4.Padding = [10 5.60000610351562 10 5.60000610351562];

            % Create UIAxes
            app.UIAxes = uiaxes(app.GridLayout4);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Layout.Row = 1;
            app.UIAxes.Layout.Column = 1;

            % Create ModemapTab
            app.ModemapTab = uitab(app.TabGroup);
            app.ModemapTab.Title = 'Modemap';

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.ModemapTab);
            app.GridLayout3.ColumnWidth = {'18.01x', '1x'};
            app.GridLayout3.RowHeight = {'1x'};
            app.GridLayout3.Padding = [10 4.90000915527344 10 4.90000915527344];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.GridLayout3);
            title(app.UIAxes_2, 'Title')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Layout.Row = 1;
            app.UIAxes_2.Layout.Column = [1 2];

            % Create IterationsTab_2
            app.IterationsTab_2 = uitab(app.TabGroup);
            app.IterationsTab_2.Title = 'Iterations';

            % Create GridLayout5
            app.GridLayout5 = uigridlayout(app.IterationsTab_2);
            app.GridLayout5.ColumnWidth = {'15.79x', '1x'};
            app.GridLayout5.RowHeight = {'1x'};
            app.GridLayout5.Padding = [10 5.60000610351562 10 5.60000610351562];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.GridLayout5);
            title(app.UIAxes_3, 'Title')
            xlabel(app.UIAxes_3, 'X')
            ylabel(app.UIAxes_3, 'Y')
            zlabel(app.UIAxes_3, 'Z')
            app.UIAxes_3.Layout.Row = 1;
            app.UIAxes_3.Layout.Column = [1 2];

            % Create ConvergenceTab
            app.ConvergenceTab = uitab(app.TabGroup);
            app.ConvergenceTab.Title = 'Convergence';

            % Create GridLayout6
            app.GridLayout6 = uigridlayout(app.ConvergenceTab);
            app.GridLayout6.ColumnWidth = {'15.79x', '1x'};
            app.GridLayout6.RowHeight = {'1x'};
            app.GridLayout6.Padding = [10 5.60000610351562 10 5.60000610351562];

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.GridLayout6);
            title(app.UIAxes_4, 'Title')
            xlabel(app.UIAxes_4, 'X')
            ylabel(app.UIAxes_4, 'Y')
            zlabel(app.UIAxes_4, 'Z')
            app.UIAxes_4.Layout.Row = 1;
            app.UIAxes_4.Layout.Column = [1 2];

            % Create SummaryTab
            app.SummaryTab = uitab(app.TabGroup);
            app.SummaryTab.Title = 'Summary';

            % Create GridLayout13
            app.GridLayout13 = uigridlayout(app.SummaryTab);
            app.GridLayout13.ColumnWidth = {'1x', '1x', '1x'};
            app.GridLayout13.RowHeight = {'1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x', '1x'};

            % Create TextArea
            app.TextArea = uitextarea(app.GridLayout13);
            app.TextArea.FontName = 'Courier New';
            app.TextArea.FontSize = 14;
            app.TextArea.Layout.Row = [1 11];
            app.TextArea.Layout.Column = [1 3];

            % Create ActionButtonsPanel
            app.ActionButtonsPanel = uipanel(app.GridLayout9);
            app.ActionButtonsPanel.Title = '  Action Buttons';
            app.ActionButtonsPanel.Layout.Row = [11 12];
            app.ActionButtonsPanel.Layout.Column = [1 3];
            app.ActionButtonsPanel.FontWeight = 'bold';
            app.ActionButtonsPanel.FontSize = 14;

            % Create GridLayout8
            app.GridLayout8 = uigridlayout(app.ActionButtonsPanel);
            app.GridLayout8.ColumnWidth = {117, 83, 117, 131, '1x', 117};
            app.GridLayout8.RowHeight = {'100x'};
            app.GridLayout8.RowSpacing = 5.13334147135417;
            app.GridLayout8.Padding = [10 5.13334147135417 10 5.13334147135417];

            % Create RunSweepButton
            app.RunSweepButton = uibutton(app.GridLayout8, 'push');
            app.RunSweepButton.ButtonPushedFcn = createCallbackFcn(app, @RunSweepButtonPushed2, true);
            app.RunSweepButton.BackgroundColor = [0.2314 0.6667 0.1961];
            app.RunSweepButton.FontSize = 18;
            app.RunSweepButton.FontWeight = 'bold';
            app.RunSweepButton.FontColor = [0.149 0.149 0.149];
            app.RunSweepButton.Layout.Row = 1;
            app.RunSweepButton.Layout.Column = 1;
            app.RunSweepButton.Text = 'Run Sweep';

            % Create StopButton
            app.StopButton = uibutton(app.GridLayout8, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.BackgroundColor = [1 0 0];
            app.StopButton.FontSize = 18;
            app.StopButton.FontWeight = 'bold';
            app.StopButton.FontColor = [0.149 0.149 0.149];
            app.StopButton.Layout.Row = 1;
            app.StopButton.Layout.Column = 2;
            app.StopButton.Text = 'Stop';

            % Create ResetButton
            app.ResetButton = uibutton(app.GridLayout8, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.BackgroundColor = [0.149 0.549 0.8667];
            app.ResetButton.FontSize = 18;
            app.ResetButton.FontWeight = 'bold';
            app.ResetButton.FontColor = [0.149 0.149 0.149];
            app.ResetButton.Layout.Row = 1;
            app.ResetButton.Layout.Column = 3;
            app.ResetButton.Text = 'Reset';

            % Create ExportButton
            app.ExportButton = uibutton(app.GridLayout8, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.BackgroundColor = [0.8 0.8 0.8];
            app.ExportButton.FontSize = 18;
            app.ExportButton.FontWeight = 'bold';
            app.ExportButton.FontColor = [0.149 0.149 0.149];
            app.ExportButton.Enable = 'off';
            app.ExportButton.Layout.Row = 1;
            app.ExportButton.Layout.Column = 6;
            app.ExportButton.Text = 'Export';

            % Create ExportOptionLabel
            app.ExportOptionLabel = uilabel(app.GridLayout8);
            app.ExportOptionLabel.FontSize = 18;
            app.ExportOptionLabel.FontWeight = 'bold';
            app.ExportOptionLabel.Enable = 'off';
            app.ExportOptionLabel.Layout.Row = 1;
            app.ExportOptionLabel.Layout.Column = 4;
            app.ExportOptionLabel.Text = 'Export Option:';

            % Create ExportOptionDropDown
            app.ExportOptionDropDown = uidropdown(app.GridLayout8);
            app.ExportOptionDropDown.Items = {'PNG', 'PDF', 'MAT', 'CSV'};
            app.ExportOptionDropDown.Enable = 'off';
            app.ExportOptionDropDown.FontSize = 14;
            app.ExportOptionDropDown.FontWeight = 'bold';
            app.ExportOptionDropDown.Layout.Row = 1;
            app.ExportOptionDropDown.Layout.Column = 5;
            app.ExportOptionDropDown.Value = 'PNG';

            % Create StatusPanel
            app.StatusPanel = uipanel(app.GridLayout9);
            app.StatusPanel.Title = 'Status';
            app.StatusPanel.Layout.Row = [10 12];
            app.StatusPanel.Layout.Column = [4 7];
            app.StatusPanel.FontWeight = 'bold';
            app.StatusPanel.FontSize = 14;

            % Create GridLayout12
            app.GridLayout12 = uigridlayout(app.StatusPanel);
            app.GridLayout12.ColumnWidth = {'1x', '1x', '1x'};

            % Create TextArea_2
            app.TextArea_2 = uitextarea(app.GridLayout12);
            app.TextArea_2.FontName = 'Courier New';
            app.TextArea_2.FontSize = 14;
            app.TextArea_2.Layout.Row = [1 2];
            app.TextArea_2.Layout.Column = [1 3];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = final_mosfet_gui_exported_v67

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end

end
