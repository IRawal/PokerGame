classdef FinalProject_GUI_12_1_24 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        HandCardsLabel_3      matlab.ui.control.Label
        HandCardsLabel_2      matlab.ui.control.Label
        HandCardsLabel        matlab.ui.control.Label
        CardsLabel            matlab.ui.control.Label
        TableCardsLabel       matlab.ui.control.Label
        YourHandCardsLabel    matlab.ui.control.Label
        BalanceamntLabel_4    matlab.ui.control.Label
        BalanceamntLabel_3    matlab.ui.control.Label
        BalanceamntLabel_2    matlab.ui.control.Label
        BalanceamntLabel      matlab.ui.control.Label
        potamntLabel          matlab.ui.control.Label
        PotLabel              matlab.ui.control.Label
        amntLabel_3           matlab.ui.control.Label
        RaisedAmountLabel_5   matlab.ui.control.Label
        amntLabel_2           matlab.ui.control.Label
        RaisedAmountLabel_4   matlab.ui.control.Label
        amntLabel             matlab.ui.control.Label
        Image                 matlab.ui.control.Image
        TexasHoldEmLabel      matlab.ui.control.Label
        FoldedCheckBox_4      matlab.ui.control.CheckBox
        CalledCheckBox_4      matlab.ui.control.CheckBox
        Player4Label          matlab.ui.control.Label
        FoldedCheckBox_3      matlab.ui.control.CheckBox
        CalledCheckBox_3      matlab.ui.control.CheckBox
        Player3Label          matlab.ui.control.Label
        RaisedAmountLabel     matlab.ui.control.Label
        FoldedCheckBox_2      matlab.ui.control.CheckBox
        CalledCheckBox_2      matlab.ui.control.CheckBox
        Player2Label          matlab.ui.control.Label
        AmountEditField       matlab.ui.control.NumericEditField
        AmountEditFieldLabel  matlab.ui.control.Label
        RaiseButton           matlab.ui.control.Button
        CallButton            matlab.ui.control.Button
        FoldButton            matlab.ui.control.Button
    end

    %variables to keep track of each players winnings and the pot
    properties (Access = private)
        p1Bal double = 100;
        p2Bal double = 100;
        p3Bal double = 100;
        p4Bal double = 100;
        potBal double = 100;
        p1Cards = {'ah','2c'};
        p2Cards = [];
        p3Cards = [];
        p4Cards = [];
        tableCards = [];
    end

    methods (Access = private)
        % Updates the labels for balances and the pot dynamically
        function updateLabels(app)
            % Update the pot label
            app.potamntLabel.Text = sprintf('$ %.2f', app.potBal);
            
            % Update each player's balance labels
            app.BalanceamntLabel.Text = sprintf('$ Balance: %.2f', app.p1Bal);
            app.BalanceamntLabel_2.Text = sprintf('$ Balance: %.2f', app.p2Bal);
            app.BalanceamntLabel_3.Text = sprintf('$ Balance: %.2f', app.p3Bal);
            app.BalanceamntLabel_4.Text = sprintf('$ Balance: %.2f', app.p4Bal);
        end

    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function InitVal(app)
            % Initialize balances and pot
            app.p1Bal = 1000; % Set initial balance for Player 1
            app.p2Bal = 1000; % Set initial balance for Player 2
            app.p3Bal = 1000; % Set initial balance for Player 3
            app.p4Bal = 1000; % Set initial balance for Player 4
            app.potBal = 0;   % Set initial pot values
            % Update the labels to reflect initial values
            updateLabels(app);
            %there should be a function here to read the card values
            %and then use the formatCards() to format them
        end

        % Button pushed function: FoldButton
        function FoldButtonPushed(app, event)
            %this should end the round for the player
        end

        % Button pushed function: CallButton
        function CallButtonPushed(app, event)
            callAmount = app.AmountEditField.Value; % Example call amount
            currentPlayerBalance = app.p1Bal; % Example for Player 1 (can be dynamic)
        
            if currentPlayerBalance >= callAmount
                app.p1Bal = app.p1Bal - callAmount; % Deduct call amount from balance
                app.potBal = app.potBal + callAmount; % Add to the pot
                updateLabels(app); % Update labels
            else
                uialert(app.UIFigure, 'Insufficient balance to call.', 'Error'); % Display error
            end
        end

        % Button pushed function: RaiseButton
        function RaiseButtonPushed(app, event)
            raiseAmount = app.AmountEditField.Value; % Get raise amount
            currentPlayerBalance = app.p1Bal; % Example for Player 1 (can be dynamic)
        
            if currentPlayerBalance >= raiseAmount && raiseAmount >=0
                app.p1Bal = app.p1Bal - raiseAmount; % Deduct from player's balance
                app.potBal = app.potBal + raiseAmount; % Add to the pot
                updateLabels(app); % Update labels
            else
                uialert(app.UIFigure, 'Insufficient balance to raise.', 'Error'); % Display error
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.3294 0.6706 0.3294];
            app.UIFigure.Position = [100 100 640 798];
            app.UIFigure.Name = 'MATLAB App';

            % Create FoldButton
            app.FoldButton = uibutton(app.UIFigure, 'push');
            app.FoldButton.ButtonPushedFcn = createCallbackFcn(app, @FoldButtonPushed, true);
            app.FoldButton.Position = [24 138 100 22];
            app.FoldButton.Text = 'Fold';

            % Create CallButton
            app.CallButton = uibutton(app.UIFigure, 'push');
            app.CallButton.ButtonPushedFcn = createCallbackFcn(app, @CallButtonPushed, true);
            app.CallButton.Position = [271 138 100 22];
            app.CallButton.Text = 'Call';

            % Create RaiseButton
            app.RaiseButton = uibutton(app.UIFigure, 'push');
            app.RaiseButton.ButtonPushedFcn = createCallbackFcn(app, @RaiseButtonPushed, true);
            app.RaiseButton.Position = [521 138 100 22];
            app.RaiseButton.Text = 'Raise';

            % Create AmountEditFieldLabel
            app.AmountEditFieldLabel = uilabel(app.UIFigure);
            app.AmountEditFieldLabel.HorizontalAlignment = 'right';
            app.AmountEditFieldLabel.FontName = 'Times New Roman';
            app.AmountEditFieldLabel.FontSize = 14;
            app.AmountEditFieldLabel.Position = [445 99 61 22];
            app.AmountEditFieldLabel.Text = '$ Amount';

            % Create AmountEditField
            app.AmountEditField = uieditfield(app.UIFigure, 'numeric');
            app.AmountEditField.Position = [521 99 100 22];
            app.AmountEditField.Value = 352;

            % Create Player2Label
            app.Player2Label = uilabel(app.UIFigure);
            app.Player2Label.FontName = 'Algerian';
            app.Player2Label.FontSize = 16;
            app.Player2Label.FontColor = [1 1 1];
            app.Player2Label.Position = [31 689 79 22];
            app.Player2Label.Text = 'Player 2';

            % Create CalledCheckBox_2
            app.CalledCheckBox_2 = uicheckbox(app.UIFigure);
            app.CalledCheckBox_2.Text = 'Called';
            app.CalledCheckBox_2.FontName = 'Times New Roman';
            app.CalledCheckBox_2.Position = [31 655 53 22];

            % Create FoldedCheckBox_2
            app.FoldedCheckBox_2 = uicheckbox(app.UIFigure);
            app.FoldedCheckBox_2.Text = 'Folded';
            app.FoldedCheckBox_2.FontName = 'Times New Roman';
            app.FoldedCheckBox_2.Position = [31 626 55 22];

            % Create RaisedAmountLabel
            app.RaisedAmountLabel = uilabel(app.UIFigure);
            app.RaisedAmountLabel.FontName = 'Times New Roman';
            app.RaisedAmountLabel.Position = [9 598 95 22];
            app.RaisedAmountLabel.Text = '$ Raised  Amount:';

            % Create Player3Label
            app.Player3Label = uilabel(app.UIFigure);
            app.Player3Label.FontName = 'Algerian';
            app.Player3Label.FontSize = 16;
            app.Player3Label.FontColor = [1 1 1];
            app.Player3Label.Position = [289 689 79 22];
            app.Player3Label.Text = 'Player 3';

            % Create CalledCheckBox_3
            app.CalledCheckBox_3 = uicheckbox(app.UIFigure);
            app.CalledCheckBox_3.Text = 'Called';
            app.CalledCheckBox_3.FontName = 'Times New Roman';
            app.CalledCheckBox_3.Position = [290 655 53 22];

            % Create FoldedCheckBox_3
            app.FoldedCheckBox_3 = uicheckbox(app.UIFigure);
            app.FoldedCheckBox_3.Text = 'Folded';
            app.FoldedCheckBox_3.FontName = 'Times New Roman';
            app.FoldedCheckBox_3.Position = [290 626 55 22];

            % Create Player4Label
            app.Player4Label = uilabel(app.UIFigure);
            app.Player4Label.FontName = 'Algerian';
            app.Player4Label.FontSize = 16;
            app.Player4Label.FontColor = [1 1 1];
            app.Player4Label.Position = [542 689 79 22];
            app.Player4Label.Text = 'Player 4';

            % Create CalledCheckBox_4
            app.CalledCheckBox_4 = uicheckbox(app.UIFigure);
            app.CalledCheckBox_4.Text = 'Called';
            app.CalledCheckBox_4.FontName = 'Times New Roman';
            app.CalledCheckBox_4.Position = [543 655 53 22];

            % Create FoldedCheckBox_4
            app.FoldedCheckBox_4 = uicheckbox(app.UIFigure);
            app.FoldedCheckBox_4.Text = 'Folded';
            app.FoldedCheckBox_4.FontName = 'Times New Roman';
            app.FoldedCheckBox_4.Position = [543 626 55 22];

            % Create TexasHoldEmLabel
            app.TexasHoldEmLabel = uilabel(app.UIFigure);
            app.TexasHoldEmLabel.FontName = 'Algerian';
            app.TexasHoldEmLabel.FontSize = 40;
            app.TexasHoldEmLabel.FontColor = [1 1 1];
            app.TexasHoldEmLabel.Position = [171 736 315 50];
            app.TexasHoldEmLabel.Text = 'Texas Hold ''Em';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [259 346 139 130];
            app.Image.ImageSource = fullfile(pathToMLAPP, '360_F_338379003_37giLQjJMMI3uFS2EFAQkzHr7QyaCS26-removebg-preview.png');

            % Create amntLabel
            app.amntLabel = uilabel(app.UIFigure);
            app.amntLabel.FontName = 'Times New Roman';
            app.amntLabel.Position = [103 598 41 22];
            app.amntLabel.Text = '{amnt}';

            % Create RaisedAmountLabel_4
            app.RaisedAmountLabel_4 = uilabel(app.UIFigure);
            app.RaisedAmountLabel_4.FontName = 'Times New Roman';
            app.RaisedAmountLabel_4.Position = [259 598 95 22];
            app.RaisedAmountLabel_4.Text = '$ Raised  Amount:';

            % Create amntLabel_2
            app.amntLabel_2 = uilabel(app.UIFigure);
            app.amntLabel_2.FontName = 'Times New Roman';
            app.amntLabel_2.Position = [353 598 41 22];
            app.amntLabel_2.Text = '{amnt}';

            % Create RaisedAmountLabel_5
            app.RaisedAmountLabel_5 = uilabel(app.UIFigure);
            app.RaisedAmountLabel_5.FontName = 'Times New Roman';
            app.RaisedAmountLabel_5.Position = [505 598 95 22];
            app.RaisedAmountLabel_5.Text = '$ Raised  Amount:';

            % Create amntLabel_3
            app.amntLabel_3 = uilabel(app.UIFigure);
            app.amntLabel_3.FontName = 'Times New Roman';
            app.amntLabel_3.Position = [599 598 41 22];
            app.amntLabel_3.Text = '{amnt}';

            % Create PotLabel
            app.PotLabel = uilabel(app.UIFigure);
            app.PotLabel.FontName = 'Algerian';
            app.PotLabel.FontSize = 24;
            app.PotLabel.FontColor = [1 1 1];
            app.PotLabel.Position = [216 317 75 30];
            app.PotLabel.Text = '$ Pot:';

            % Create potamntLabel
            app.potamntLabel = uilabel(app.UIFigure);
            app.potamntLabel.FontName = 'Times New Roman';
            app.potamntLabel.FontSize = 24;
            app.potamntLabel.FontColor = [1 1 1];
            app.potamntLabel.Position = [305 315 113 32];
            app.potamntLabel.Text = '{pot amnt}';

            % Create BalanceamntLabel
            app.BalanceamntLabel = uilabel(app.UIFigure);
            app.BalanceamntLabel.FontName = 'Times New Roman';
            app.BalanceamntLabel.FontSize = 14;
            app.BalanceamntLabel.Position = [445 72 109 22];
            app.BalanceamntLabel.Text = '$ Balance: {amnt}';

            % Create BalanceamntLabel_2
            app.BalanceamntLabel_2 = uilabel(app.UIFigure);
            app.BalanceamntLabel_2.FontName = 'Times New Roman';
            app.BalanceamntLabel_2.Position = [9 568 95 22];
            app.BalanceamntLabel_2.Text = '$ Balance: {amnt}';

            % Create BalanceamntLabel_3
            app.BalanceamntLabel_3 = uilabel(app.UIFigure);
            app.BalanceamntLabel_3.FontName = 'Times New Roman';
            app.BalanceamntLabel_3.Position = [259 568 95 22];
            app.BalanceamntLabel_3.Text = '$ Balance: {amnt}';

            % Create BalanceamntLabel_4
            app.BalanceamntLabel_4 = uilabel(app.UIFigure);
            app.BalanceamntLabel_4.FontName = 'Times New Roman';
            app.BalanceamntLabel_4.Position = [505 568 95 22];
            app.BalanceamntLabel_4.Text = '$ Balance: {amnt}';

            % Create YourHandCardsLabel
            app.YourHandCardsLabel = uilabel(app.UIFigure);
            app.YourHandCardsLabel.FontName = 'Times New Roman';
            app.YourHandCardsLabel.FontSize = 18;
            app.YourHandCardsLabel.Position = [24 71 152 24];
            app.YourHandCardsLabel.Text = 'Your Hand: {Cards}';

            % Create TableCardsLabel
            app.TableCardsLabel = uilabel(app.UIFigure);
            app.TableCardsLabel.FontName = 'Algerian';
            app.TableCardsLabel.FontSize = 24;
            app.TableCardsLabel.FontColor = [1 1 1];
            app.TableCardsLabel.Position = [122 267 168 30];
            app.TableCardsLabel.Text = 'Table Cards:';

            % Create CardsLabel
            app.CardsLabel = uilabel(app.UIFigure);
            app.CardsLabel.FontName = 'Times New Roman';
            app.CardsLabel.FontSize = 24;
            app.CardsLabel.FontColor = [1 1 1];
            app.CardsLabel.Position = [305 265 84 32];
            app.CardsLabel.Text = '{Cards}';

            % Create HandCardsLabel
            app.HandCardsLabel = uilabel(app.UIFigure);
            app.HandCardsLabel.FontName = 'Times New Roman';
            app.HandCardsLabel.FontSize = 18;
            app.HandCardsLabel.Position = [9 536 113 24];
            app.HandCardsLabel.Text = 'Hand: {Cards}';

            % Create HandCardsLabel_2
            app.HandCardsLabel_2 = uilabel(app.UIFigure);
            app.HandCardsLabel_2.FontName = 'Times New Roman';
            app.HandCardsLabel_2.FontSize = 18;
            app.HandCardsLabel_2.Position = [259 536 113 24];
            app.HandCardsLabel_2.Text = 'Hand: {Cards}';

            % Create HandCardsLabel_3
            app.HandCardsLabel_3 = uilabel(app.UIFigure);
            app.HandCardsLabel_3.FontName = 'Times New Roman';
            app.HandCardsLabel_3.FontSize = 18;
            app.HandCardsLabel_3.Position = [505 536 113 24];
            app.HandCardsLabel_3.Text = 'Hand: {Cards}';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = FinalProject_GUI_12_1_24

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @InitVal)

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