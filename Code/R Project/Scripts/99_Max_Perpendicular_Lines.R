## SOURCE: https://stackoverflow.com/questions/55854273/how-to-find-the-longest-chord-perpendicular-to-the-maximum-chord-through-a-polyg
## this returns the i,j of the largest elements in matrix `m`
findmax <- function(m){
  v = which.max(m) - 1
  c(v %% nrow(m)+1, v %/% nrow(m)+1)
}

## Return an sf line through a point at an angle of a given length
pline <- function(pt, angle, length){
  st_linestring(
    cbind(
      pt[1] + c(length,-length) * sin(angle),
      pt[2] + c(length,-length) * cos(angle)
    )
  )
}

## return the line that is the chord at angle perp.angle of length through any of the polygon vertices
max_perp_chord <- function(polygon, perp.angle, length){
  ## get polygon vertices
  pts = st_coordinates(polygon)[,c(1,2)]
  ## return the perpendicular lines
  perplines = lapply(1:nrow(pts), function(i){
    ## through the i-th vertex
    xy = pts[i,,drop=FALSE]
    perpline = pline(xy, perp.angle, length)
    ## intersect it with the polygon
    inters = st_intersection(polygon, perpline)
    inters
  }
  )
  
  ## get the vector of intersection lengths, find the largest
  perplengths = unlist(lapply(perplines, st_length))
  longest = which.max(perplengths)
  ## return the longest line
  perplines[[longest]]
  
}

### find the max length chord across all pairs of vertex points
max_chord <- function(polygon){
  ## get polygon coordinates
  xy = st_coordinates(polygon)[,1:2]
  
  ## compute the distance matrix and find largest element
  df_dist = as.matrix(dist(xy))
  maxij = findmax(df_dist)
  
  ## those elements define the largest chord
  chord = rbind(
    xy[maxij[1],],
    xy[maxij[2],]
  )
  chord
}


find_max_chord <- function(spolygon, chord=max_chord(spolygon)){
  
  ## Now compute the length and angle of the longest chord
  chord.length = sqrt(diff(chord[,1])^2 + diff(chord[,2])^2)
  chord.theta = atan2(diff(chord[,1]), diff(chord[,2]))
  
  ## The perpendicular is at this angle plus pi/2 radians
  perp = chord.theta + pi/2
  max_perp_chord(spolygon, perp, chord.length)
}