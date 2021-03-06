# Timeline

[`Timeline.squash/1`](https://github.com/jkakar/timeline/blob/master/lib/timeline.ex#L2-L14)
squashes overlapping events into a single timeline without overlaps:

```elixir
#      1    2    3    4    5    6    7    8    9    10   11   12
#  ... E1==================E1 ....................................>
#  ........ E2========E2 .........................................>
#  ............................ E3===E3 ..........................>
#  ............................ E4========E4 .....................>
#  ........................................... E5========E5 ......>
#  ................................................ E6===E6 ......>
#      >--------- 4 --------<   >---- 2 ---<   >---- 2 ---<
timelines = [{1, 5}, {2, 4}, {6, 7}, {6, 8}, {9, 11}, {10, 11}]
squashed_timelines = [{1, 5}, {6, 8}, {9, 11}]
squashed_timelines ^= Timeline.squash(timelines)
```
