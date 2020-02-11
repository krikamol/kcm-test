function generate_power_plot(ys,xv,xl,yl,yll,pltitle,legs,outfile)
%GENERATE_PLOT produces beautiful plot for the paper

figure();
set(gcf,'Visible','on');

ls = ["-ok","--*r",":xb","-.^m"];
for i=1:size(ys,1)
    plot(xv,ys(i,:),char(ls(i)),'LineWidth',4,'MarkerSize',14); hold on;
end
hold off;

xlabel(xl,'FontSize',28,'Interpreter','latex');
ylabel(yl,'FontSize',28,'Interpreter','latex');
ylim(yll);

xtl = get(gca,'XTickLabel');
set(gca,'XTickLabel',xtl,'fontsize',20)

ytl = get(gca,'YTickLabel');
set(gca,'YTickLabel',ytl,'fontsize',20)

title(pltitle,'FontSize',20,'Interpreter','latex');
legend(legs,'Location','southeast','FontSize',24);
axis square;

saveas(gcf,char(outfile),'epsc');

end