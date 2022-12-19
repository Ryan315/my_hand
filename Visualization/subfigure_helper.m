function [subfigure, pks, ploc, buffer_amp, buffer_t] = subfigure_helper(input, visable)
    subfigure = figure('visible', visable);
    len_input = length(input);
    poly_order = 5;

    plot(input);
    grid on

    [pks, ploc] = findpeaks(input,"MinPeakHeight",mean(input));
    hold on; plot(ploc, pks, '*', 'MarkerSize', 8, 'MarkerFaceColor','auto');
    pfit = polyfit(ploc, pks, poly_order);
    fitx = linspace(0, len_input, len_input);
    pfity = polyval(pfit, fitx);
    hold on; plot(pfity,'LineWidth',2);
    
    [vks, vloc] = findpeaks(-input,"MinPeakHeight",mean(-input));
    vks = -vks;
    hold on; plot(vloc, vks, 's', 'MarkerSize', 8, 'MarkerFaceColor','none', "MarkerEdgeColor",'b');
    vfit = polyfit(vloc, vks, poly_order);
    vfity = polyval(vfit, fitx);
    hold on; plot(vfity, 'LineWidth', 2);
    ylim([0.5*min(input), 1.2*max(input)]);
    legend(["","peak","peak-fit","valley", "valley-fit"], 'NumColumns', 2);
    
%     ploc'
%     vloc'
    temp1 = [ploc' vloc'];
    loc_p_v = sort(temp1);
    buffer_amp = [];
    buffer_t = [];
    for ind = 1:length(loc_p_v)-1
        if any(ploc(:) == loc_p_v(ind)) && any(vloc(:) == loc_p_v(ind+1))
            ind_p = find(ploc == loc_p_v(ind));
            ind_v = find(vloc == loc_p_v(ind+1));
            amp = pks(ind_p)-vks(ind_v);
            buffer_amp = [buffer_amp amp];
            buffer_t = [buffer_t loc_p_v(ind+1)-loc_p_v(ind)];
            buffer_t
        end
    end
%     buffer_amp
%     figure
%     plot(buffer_amp)
end