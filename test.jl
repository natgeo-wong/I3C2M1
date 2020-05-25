using Contour
using Seaborn
using PolygonOps

x = -10:0.2:10
y = -10:0.2:10
z = [Float64((xi^2 + yi^2)) for xi in x, yi in y]
z = z .+ rand(length(x),length(y))*3
c = contours(x, y, z, [10,30])


close(); figure();

for cl in levels(c)
    lvl = level(cl) # the z-value of this contour level
    for line in lines(cl)
        global xs, ys = coordinates(line) # coordinates of this line segment
        plot(xs,ys) # pseuod-code; use whatever plotting package you prefer
    end
end

gcf()

crd = [[xs[1],ys[1]],[xs[2],ys[2]]];

for ii = 3 : length(xs)
    global crd = cat(crd,[xs[ii],ys[ii]],dims=1)
end

crd = vcat(crd,[xs[1],ys[1]])
