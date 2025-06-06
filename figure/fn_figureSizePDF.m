function fn_figureSizePDF(figureHandle,pdfPath, pdfAppendName)


   % Step 1: Maximize the figure to fill the screen (excluding the taskbar)
    % Get the screen size and account for the taskbar
    screenSize = get(0, 'ScreenSize');  % Get the screen size
    usableScreen = java.awt.Toolkit.getDefaultToolkit.getScreenInsets(java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment.getDefaultScreenDevice.getDefaultConfiguration);
    taskbarHeight = usableScreen.bottom;  % Height of the taskbar (in pixels)
    usableHeight = screenSize(4) - taskbarHeight;  % Usable screen height

    % Set figure size to fill the usable screen area
    set(figureHandle, 'Units', 'pixels');
    figPos = get(figureHandle, 'Position');
    figPos(3) = screenSize(3);  % Max width to screen width
    figPos(4) = usableHeight;   % Max height to usable screen height
    set(figureHandle, 'Position', figPos);  % Apply the new figure size

    % Step 2: Set the PaperPositionMode to 'manual' to prevent resizing
    set(figureHandle, 'PaperPositionMode', 'manual');

    % Get the current figure size (in inches) for a 1:1 match with the PDF
    screenInches = get(figureHandle, 'Position') ./ get(0, 'ScreenPixelsPerInch');
    
    % Step 3: Set the PaperSize to match the screen size exactly
    set(figureHandle, 'PaperUnits', 'inches');
    set(figureHandle, 'PaperSize', screenInches(3:4));  % Set the paper size to match figure size
    set(figureHandle, 'PaperPosition', [0 0 screenInches(3) screenInches(4)]);  % Match the paper position

    % Step 4: Save the figure to PDF without scaling or altering the font size
    % Step 4: Save the figure to PDF using '-bestfit' to avoid overflow issues

  
    print(figureHandle,[pdfPath filesep 'temp.pdf'], '-dpdf', '-bestfit', '-r300');  % Save as high-res PDF
    append_pdfs([pdfPath filesep pdfAppendName], [pdfPath filesep 'temp.pdf']);


end 