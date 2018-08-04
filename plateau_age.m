function [age,sigw,mswd,n] = plateau_age(l,le,Ar40K40,sigAK)

    n = length(Ar40K40);
    x = 1:n;
    [t,sigt] = KAr(l,le,Ar40K40,sigAK);
    f = figure;
    errorbar(x,t,2*sigt)
    drawnow
    accept = 0;
    
    while ~accept
        % Get analyses on plateau
        rect = getrect(f);
        idx = x>rect(1) & x<rect(1)+rect(3);
        % Show selected samples
        hold off
        errorbar(x,t,2*sigt)
        hold on
        plot(x(idx),t(idx),'ko')
        drawnow
        % Compute weighted mean and mswd
        [age,sigw,mswd] = w_mean(t(idx),sigt(idx));
        sig_mswd = sqrt(2/(sum(idx)-2));
        fprintf('Age: %0d \nMSWD: %0.2f +/- %0.2f\n',age,mswd,2*sig_mswd)
        inp = input('Accept this selection?','s');
        if strcmp(inp,'Y') || strcmp(inp,'y')
            accept = 1;
        end
    end
    inp = input('Save plot?','s');
    if strcmp(inp,'Y') || strcmp(inp,'y')
        nam = input('Name: ','s');
        title(strcat('Plateau Age, ',nam))
        loc = input('Location: ','s');
        print(strcat(loc,nam),'-depsc')
    end
    close(f)
    n = sum(idx);

end