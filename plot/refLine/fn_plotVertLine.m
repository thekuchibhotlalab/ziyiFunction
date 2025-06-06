function fn_plotVertLine(xLoc,ylimm)
    hold on; 
    for i = 1:length(xLoc)
        plot([xLoc(i) xLoc(i)],ylimm,'Color',[0.8 0.8 0.8],'LineWidth',2);
    end 
end 