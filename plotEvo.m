function plotEvo(ydim,yevdim,xtdim)

h5=plot(ydim(:,1),ydim(:,3))

hold on
grid on
h2=plot(xtdim(),0,'ks');
h3=plot(yevdim(:,1),yevdim(:,3),'rs');


for i=1:length(xtdim)
    h3=line([xtdim(i) yevdim(2*i-1,1)],[0 yevdim(2*i-1,3)],'Color','red')
    h3=line([xtdim(i) yevdim(2*i,1)],[0 yevdim(2*i,3)],'Color','black')
    
end
legend(h5,{'First'})
end