clc
clear
tc_init_root
tc_append_database('TCHEA2')
tc_check_error;
tc_open_database('MOBNI4');
tc_check_error;
tc_element_select('ni cr al fe ')
tc_check_error;
tc_phase_reject('*')
tc_check_error;
tc_phase_select('FCC_A1')
tc_check_error;
tc_get_data
tc_check_error;
tc_set_condition('p',100000);
tc_check_error;
tc_set_condition('n',1);
tc_check_error;
tc_set_condition('t',973);
tc_check_error;
tc_set_minimization('off');

[a,b]=tc_error;
if a~=0
    s=sprintf('ERROR %d',a);
    disp(s);
    disp(b);
    return;
end

disp('phases:');
[~, phases]=tc_list_phase
disp('conditions:');
[~, conditions]=tc_list_conditions;

n=1;
for x_cr = 0.01:0.001:0.97
    for x_al = 0.01:0.001:0.08
        for x_fe = 0.01:0.001:0.5

            tic
            x_ni = 1 - x_cr-x_al - x_fe;
           if ((x_cr+x_al+x_fe)<0.9999)
            fprintf('x_cr = %.3f |x_al = %.3f | x_fe = %.3f \n',x_cr, x_al,x_fe)
            tc_set_condition('x(Cr)',x_cr);
            tc_check_error;
            tc_set_condition('x(Al)',x_al);
            tc_check_error;
            tc_set_condition('x(Fe)',x_fe);
            tc_check_error;
            tc_set_phase_status('FCC_A1','entered',1);
            tc_check_error;
            tc_set_phase_status('FCC_A1#2','suspended',0);
            tc_check_error;
            tc_poly3_command('s-a-s f');
            tc_compute_equilibrium;    
            tc_check_error;

% get the Gibbs energy
G_Fcc = tc_get_value('GM(FCC_A1)') -8.314*973*(x_cr*log(x_cr)+x_al*log(x_al)+...
x_fe*log(x_fe)+(1-x_cr-x_al-x_fe)*log(1-x_cr-x_al-x_fe));

 X(n,1)=x_cr;
 X(n,2)=x_al;
 X(n,3)=x_fe;
 Y(n,1)=G_Fcc;

 n=n+1;
            end
        end
    end
end
tc_deinit

