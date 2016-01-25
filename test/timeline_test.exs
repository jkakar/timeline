defmodule TimelineTest do
  use ExUnit.Case, async: true
  doctest Timeline

  test "Timeline.squash is effectively a no-op when none of the timelines overlap" do
    #      1    2    3    4    5
    #  ... E1===E1 ...............>
    #  ............. E2===E2 .....>
    #      >- 1 -<   >- 1 -<
    timelines = [{1, 2}, {3, 4}]
    assert Timeline.squash(timelines) == timelines
  end

  test "Timeline.squash squashes two timelines that partially overlap into a single timeline" do
    #      1    2    3    4    5
    #  ... P1========P1 ..........>
    #  ........ P2========P2 .....>
    #      >------ 3 ------<
    timelines = [{1, 3}, {2, 4}]
    squashed_timelines = [{1, 4}]
    assert Timeline.squash(timelines) == squashed_timelines
  end

  test "Timeline.squash squashes multiple overlapping timelines into a distinct list of timelines" do
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
    assert Timeline.squash(timelines) == squashed_timelines
  end
end
