function PlotJoints(vidFrame,joints,EpL)
%,epi_lines
    % Show the frame image for vue2/vue4
    figure
    imshow(vidFrame)
    % Plot the joint coordinates on the image  
    axis on
    hold on
    plot(joints(1,1),joints(1,2), 'c*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(2,1),joints(2,2), 'b*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(3,1),joints(3,2), 'm*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(4,1),joints(4,2), 'g*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(5,1),joints(5,2), 'r*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(6,1),joints(6,2), 'y*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(7,1),joints(7,2), 'c*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(8,1),joints(8,2), 'b*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(9,1),joints(9,2), 'm*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(10,1),joints(10,2), 'g*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(11,1),joints(11,2), 'r*', 'MarkerSize', 5, 'LineWidth', 2);
    plot(joints(12,1),joints(12,2), 'y*', 'MarkerSize', 5, 'LineWidth', 2);
    % Plot the Epipolar lines
    x = 0:1:1960;
    y = -(EpL(1,1)*x + EpL(3,1))/EpL(2,1);
    plot(x,y,'c', 'LineWidth', 2);
    y = -(EpL(1,2)*x + EpL(3,2))/EpL(2,2);
    plot(x,y,'b', 'LineWidth', 2);
    y = -(EpL(1,3)*x + EpL(3,3))/EpL(2,3);
    plot(x,y,'m', 'LineWidth', 2);
    y = -(EpL(1,4)*x + EpL(3,4))/EpL(2,4);
    plot(x,y,'g', 'LineWidth', 2);
    y = -(EpL(1,5)*x + EpL(3,5))/EpL(2,5);
    plot(x,y,'r', 'LineWidth', 2);
    y = -(EpL(1,6)*x + EpL(3,6))/EpL(2,6);
    plot(x,y,'y', 'LineWidth', 2);
    y = -(EpL(1,7)*x + EpL(3,7))/EpL(2,7);
    plot(x,y,'c', 'LineWidth', 2);
    y = -(EpL(1,8)*x + EpL(3,8))/EpL(2,8);
    plot(x,y,'b', 'LineWidth', 2);
    y = -(EpL(1,9)*x + EpL(3,9))/EpL(2,9);
    plot(x,y,'m', 'LineWidth', 2);
    y = -(EpL(1,10)*x + EpL(3,10))/EpL(2,10);
    plot(x,y,'g', 'LineWidth', 2);
    y = -(EpL(1,11)*x + EpL(3,11))/EpL(2,11);
    plot(x,y,'r', 'LineWidth', 2);
    y = -(EpL(1,12)*x + EpL(3,12))/EpL(2,12);
    plot(x,y,'y', 'LineWidth', 2);
    hold off



end