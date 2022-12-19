function distance_tap= feature_calculation(filename, fps, flag_figure)
%     filename = "9170-fingertap-right-enhanced.mat";
%     fps = 30;
    % keypoints
    p1 = 5;
    p2 = 9;
    show_cut = false;

    load(filename);
    if exist("right")==1
        pos = right;
    elseif exist("left")==1
        pos = left;
    else
        pos = hand;
    end


    % for all the timepoints
    landmark_x_all = pos(:,:,1);
    landmark_y_all = pos(:,:,2);
    landmark_z_all = pos(:,:,3); 
    
    distance_all = sqrt((landmark_x_all(:,p1)-landmark_x_all(:,p2)).^2+ (landmark_y_all(:,p1)-landmark_y_all(:,p2)).^2+(landmark_z_all(:,p1)-landmark_z_all(:,p2)).^2);
    
    L_all = size(pos,1);
    distance_fft_all = fft(distance_all);
    P2_all = abs(distance_fft_all/L_all);
    P1_all = P2_all(1:floor(L_all/2)+1);
    P1_all(2:end-1) = 2*P1_all(2:end-1);
    f_all = fps*(0:(L_all/2))/L_all;


    if show_cut
        % for cut a specific period for display
        pstart = 1;
        pend = 35; 
        pperiod = pend-pstart;
        landmark_x = pos(pstart:pend,:,1);
        landmark_y = pos(pstart:pend,:,2);
        landmark_z = pos(pstart:pend,:,3);
    
        distance = sqrt((landmark_x(:,p1)-landmark_x(:,p2)).^2+ (landmark_y(:,p1)-landmark_y(:,p2)).^2+(landmark_z(:,p1)-landmark_z(:,p2)).^2);
        
        % for FFT
        T = 1/fps;
        L = pend-pstart;
        distance_fft = fft(distance);
        P2 = abs(distance_fft/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
        f = fps*(0:(L/2))/L;
    end

    %%
    if flag_figure
        row = 0;
        numcolumn = 4;
        if show_cut
            numrow = 3;
            row = row + 1;
            figure
            subplot(numrow,numcolumn,(row-1)*numcolumn+1)
            plot(landmark_x)
            xlabel("x")
            
            subplot(numrow,numcolumn,(row-1)*numcolumn+2)
            plot(landmark_y)
            xlabel("y")
            
            subplot(numrow,numcolumn,(row-1)*numcolumn+3)
            plot(landmark_z)
            xlabel("z")
            
            subplot(numrow,numcolumn,(row-1)*numcolumn+4)
            plot(pos(:,:,1))
            xlabel("all")
        else
            numrow = 2;
        end


        % subplot(numrow,numcolumn,(row-1)*numcolumn+4)
        % [r, c] = size(distance__);
        % hold on
        % for i = 1:c
        %     plot(distance__(:, i))
        % end
        % xlabel("distance")
        
        %% PCA
    %     [pc_x,score_x,latent_x,tsquare_x,explained_x] = pca(landmark_x);
    %     [pc_y,score_y,latent_y,tsquare_y,explained_y] = pca(landmark_y);
    %     [pc_z,score_z,latent_z,tsquare_z,explained_z] = pca(landmark_z);
    
        [pc_x,score_x,latent_x,tsquare_x,explained_x] = pca(landmark_x_all);
        [pc_y,score_y,latent_y,tsquare_y,explained_y] = pca(landmark_y_all);
        [pc_z,score_z,latent_z,tsquare_z,explained_z] = pca(landmark_z_all);
        
        row = row + 1;
        subplot(subplot(numrow,numcolumn,(row-1)*numcolumn+1));
        hold on
        yyaxis left
        h(1) = plot(score_x(:,1), 'Color','b', 'LineStyle','-');
        h(2) = plot(score_x(:,2), 'Color','m', 'LineStyle', '-');
        xlabel("PCA");
        yyaxis right
        xx = (1:length(explained_x))*pperiod/length(explained_x);
        h(3) = bar(xx, explained_x);
        ylabel("explaned")
        legend(h(1:2), "c1", "c2")
        
        
        subplot(subplot(numrow,numcolumn,(row-1)*numcolumn+2));
        hold on
        yyaxis left
        h(1) = plot(score_y(:,1), 'Color','b', 'LineStyle','-');
        h(2) = plot(score_y(:,2), 'Color','m', 'LineStyle', '-');
        xlabel("PCA");
        yyaxis right
        xx = (1:length(explained_y))*pperiod/length(explained_y);
        h(3) = bar(xx, explained_y);
        ylabel("explaned")
        legend(h(1:2), "c1", "c2")
        
        subplot(subplot(numrow,numcolumn,(row-1)*numcolumn+3));
        hold on
        yyaxis left
        h(1) = plot(score_z(:,1), 'Color','b', 'LineStyle','-');
        h(2) = plot(score_z(:,2), 'Color','m', 'LineStyle', '-');
        xlabel("PCA");
        yyaxis right
        xx = (1:length(explained_z))*pperiod/length(explained_z);
        h(3) = bar(xx, explained_z);
        ylabel("explaned")
        legend(h(1:2), "c1", "c2")
        
        % [wcoeff_y,~,latent_y,~,explained_y] = pca(landmark_y_inv,'VariableWeights','variance');
        % [wcoeff_z,~,latent_z,~,explained_z] = pca(landmark_z_inv,'VariableWeights','variance');
        
        
        %% distance of specific keypoints in the time cut
        % row = row + 1;
        str = "distance keypoint %d to %d";
        % subplot(numrow,numcolumn,(row-1)*numcolumn+1)
        % plot(distance)
        % xlabel(sprintf(str, p1-1, p2-1))
        % 
        % subplot(numrow,numcolumn,(row-1)*numcolumn+2)
        % plot(f,P1)
        % xlabel('f (Hz)')
        % 
        % subplot(numrow,numcolumn,(row-1)*numcolumn+3)
        % plot(diff(distance))
        % xlabel('speed')
        % 
        % subplot(numrow,numcolumn,(row-1)*numcolumn+4)
        % plot(diff(distance,2))
        % xlabel('acc')
        
        %% distance of specific keypoints in all time series
        row = row + 1;
        subplot(numrow,numcolumn,(row-1)*numcolumn+1)
        plot(distance_all)
        xlabel(sprintf(str, p1-1, p2-1))
        
        subplot(numrow,numcolumn,(row-1)*numcolumn+2)
        plot(f,P1)
        xlabel('f (Hz)-all')
        
        subplot(numrow,numcolumn,(row-1)*numcolumn+3)
        plot(diff(distance_all))
        xlabel('speed-all')
        
        subplot(numrow,numcolumn,(row-1)*numcolumn+4)
        plot(diff(distance_all,2))
        xlabel('acc')
    end
    distance_tap = distance_all;
end






