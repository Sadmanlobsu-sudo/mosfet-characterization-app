function [Id_final, region, trace, used_newton, iter_count] = solver(Vgs, Vds, Id_init, p)

    Id = Id_init;
    
    trace = zeros(p.max_iters + 20,1);
    trace_index = 0;
    
    used_newton = false;
    iter_count = 0;
    converged = false;
    region = 0;
    
    % FIXED POINT ITERATION
    
    for m = 1:p.max_iters
    
        Vgs_int = Vgs - Id*p.Rs;
        [Inew, reg] = calc_model(Vgs_int, Vds, p);
    
        Id_next = (1 - p.alpha)*Id + p.alpha*Inew;
    
        diff = abs(Id_next - Id);
    
        trace_index = trace_index + 1;
        trace(trace_index) = max(diff, eps);
    
        if diff < p.tol
            Id = Id_next;
            region = reg;
            iter_count = m;
            converged = true;
            break
        end
    
        if p.clamp_id
            Id = max(0, Id_next);
        else
            Id = Id_next;
        end
    
        iter_count = m;
    
    end
        
    % NEWTON FALLBACK
    
    if ~converged && p.newton_fallback
    
        used_newton = true;
    
        for n = 1:10
    
            Vgs_int = Vgs - Id*p.Rs;
            [Id_model, reg] = calc_model(Vgs_int, Vds, p);
    
            F = Id - Id_model;
    
            [Id_p, ~] = calc_model(Vgs - (Id + p.delta)*p.Rs, Vds, p);
            [Id_mi, ~] = calc_model(Vgs - (Id - p.delta)*p.Rs, Vds, p);
    
            dF = 1 - (Id_p - Id_mi)/(2*p.delta);
    
            if abs(dF) < 1e-12
                break
            end
    
            Id_new = Id - F/dF;
    
            diff = abs(Id_new - Id);
    
            trace_index = trace_index + 1;
            trace(trace_index) = max(diff, eps);
    
            if p.clamp_id
                Id = max(0, Id_new);
            else
                Id = Id_new;
            end
    
            iter_count = iter_count + 1;
    
            if diff < p.tol
                break
            end
    
        end
    
        region = reg;
    
    end
    
    % TRACE CLEANUP
    
    if trace_index == 0
        trace = eps;
    else
        trace = trace(1:trace_index);
    end
    
    Id_final = Id;

end