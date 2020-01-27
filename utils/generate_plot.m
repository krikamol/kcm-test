function generate_plot(ys,xv,xl,yl,pltitle,output_file)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

set(gcf,'Visible','on');
plot(xv,ys,'LineWidth',2);
xlabel(xl);
ylabel(yl);
ylim([0 0.2]);
title(pltitle);
%saveas(gcf,output_file);

end