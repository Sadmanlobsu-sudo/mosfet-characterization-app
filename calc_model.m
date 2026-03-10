function [Id, region] = calc_model(Vgs_int, Vds, p)

    k = (p.mu_n * 1e-4) * p.Cox * p.W_L;
    
    if strcmp(p.mode_criterion,"Internal")
        Vov = Vgs_int - p.Vth;
    else
        Vov = p.Vov_user;
    end
    
    if Vov <= 0
        Id = 0;
        region = 0;
    
    elseif Vds < Vov
        Id = k*(Vov*Vds - 0.5*Vds^2)*(1 + p.lambda*Vds);
        region = 1;
    
    else
        Id = 0.5*k*Vov^2*(1 + p.lambda*Vds);
        region = 2;
    
    end

end