//https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/

// The main function that returns true if line segment 'p1q1'
// and 'p2q2' intersect.
boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2)
{
    // Find the four orientations needed for general and
    // special cases
    float o1 = orientation(p1, q1, p2);
    float o2 = orientation(p1, q1, q2);
    float o3 = orientation(p2, q2, p1);
    float o4 = orientation(p2, q2, q1);
 
    // General case
    if (o1 != o2 && o3 != o4)
        return true;
 
    // Special Cases
    // p1, q1 and p2 are colinear and p2 lies on segment p1q1
    if (o1 == 0 && onSegment(p1, p2, q1)) return true;
 
    // p1, q1 and q2 are colinear and q2 lies on segment p1q1
    if (o2 == 0 && onSegment(p1, q2, q1)) return true;
 
    // p2, q2 and p1 are colinear and p1 lies on segment p2q2
    if (o3 == 0 && onSegment(p2, p1, q2)) return true;
 
     // p2, q2 and q1 are colinear and q1 lies on segment p2q2
    if (o4 == 0 && onSegment(p2, q1, q2)) return true;
 
    return false; // Doesn't fall in any of the above cases
}


// Given three colinear points p, q, r, the function checks if
// point q lies on line segment 'pr'
boolean onSegment(PVector p, PVector q, PVector r)
{
  if (q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) && q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y))
     return true;
 
  return false;
}

// To find orientation of ordered triplet (p, q, r).
// The function returns following values
// 0 --> p, q and r are colinear
// 1 --> Clockwise
// 2 --> Counterclockwise
float orientation(PVector p, PVector q, PVector r)
{
    // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
    // for details of below formula.
    float val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);
 
    if (val == 0){
      return 0;  // colinear
    }
    else if (val > 0) {
      return 1; // Clockwise
    }
    else{
      return 2; // Counterclockwise
    }
}
