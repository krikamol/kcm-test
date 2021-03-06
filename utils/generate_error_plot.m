function generate_error_plot(ys,xv,alpha,xl,yl,yll,pltitle,legs,outfile)
%GENERATE_ERROR_PLOT This function produces beautiful plots of Type-I errors

figure();
set(gcf,'Visible','on');

[~,fname,~] = fileparts(outfile);
save(sprintf('%s.mat',fname),'ys','xv','alpha','xl','yl','yll','pltitle','legs','outfile');

ls = ['-ok','--*r',':xb','-.^m'];
for i=1:size(ys,1)
    plot(xv,ys(i,:),char(ls(i)),'LineWidth',4,'MarkerSize',14); hold on;
end
hold off;

yline(alpha,':','$\alpha$','LineWidth',4,'Interpreter','latex');
xlabel(xl,'FontSize',28,'Interpreter','latex');
ylabel(yl,'FontSize',28,'Interpreter','latex');
ylim(yll);
grid on

ax = gca;
ax.YAxis.FontSize = 20;
ax.XAxis.FontSize = 20;

title(pltitle,'FontSize',20,'Interpreter','latex');
legend(legs,'FontSize',24);
pbaspect([2 1 1]);

saveas(gcf,char(outfile),'epsc');

end
