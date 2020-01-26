function generate_plot(ys,xv,xl,yl,pltitle,output_file)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

set(gcf,'Visible','off');
plot(xv,ys);
xlabel(xl);
ylabel(yl);
title(pltitle);
saveas(gcf,output_file,'epsc');

end