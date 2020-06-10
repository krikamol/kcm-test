function generate_power_plot(ys,xv,xl,yl,yll,pltitle,legs,outfile)
%GENERATE_PLOT produces beautiful plot for the paper

figure();
set(gcf,'Visible','on');

[~,fname,~] = fileparts(outfile);
save(sprintf('%s.mat',fname),'ys','xv','xl','yl','yll','pltitle','legs','outfile');

ls = ["-ok","--*r",":xb","-.^m"];
for i=1:size(ys,1)
    plot(xv,ys(i,:),char(ls(i)),'LineWidth',4,'MarkerSize',14); hold on;
    %semilogx(xv,ys(i,:),char(ls(i)),'LineWidth',4,'MarkerSize',14); hold on;
end
hold off;

xlabel(xl,'FontSize',28,'Interpreter','latex');
ylabel(yl,'FontSize',28,'Interpreter','latex');
ylim(yll);
%xlim([xv(1)-10,xv(end)]);
grid on

ax = gca;
ax.YAxis.FontSize = 20;
ax.XAxis.FontSize = 20;

title(pltitle,'FontSize',20,'Interpreter','latex');
legend(legs,'Location','southeast','FontSize',24);
pbaspect([2 1 1]);

saveas(gcf,char(outfile),'epsc');

end