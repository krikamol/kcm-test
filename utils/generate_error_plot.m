function generate_error_plot(ys,xv,alpha,xl,yl,yll,pltitle,legs,outfile)
%GENERATE_PLOT produces beautiful plot for the paper

figure();
set(gcf,'Visible','on');

ls = ["-ok","--*r",":xb","-.^m"];
for i=1:size(ys,1)
    plot(xv,ys(i,:),char(ls(i)),'LineWidth',4,'MarkerSize',4); hold on;
end
hold off;

yline(alpha,'--','alpha','LineWidth',4);
xlabel(xl,'FontSize',18,'Interpreter','latex');
ylabel(yl,'FontSize',18,'Interpreter','latex');
ylim(yll);
title(pltitle,'FontSize',20,'Interpreter','latex');
legend(legs);

saveas(gcf,char(outfile),'epsc');

end