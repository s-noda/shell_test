window_placer
==========

<h3> USAGE </h3>
<div>
  source window_placer.sh; place_windows_from_string
  "$TARGET_WINDOW_ID_PATTERN" "$WINDOW_W" "$WINDOW_H" "$START_X" "$START_Y"
  "$MARGIX_X" "$MARGIN_Y";
</div>
<ul>
  <li> "TARGET_WINDOW_ID_PATTERN": Use to select place target window,
    such as  `wmctrl -l -G | grep "$TARGET_WINDOW_ID_PATTERN"`. </li>
  <li> "WINDOW_W|H": Target window size. </li>
  <li> "START_X|Y": Initial position for placing windows.
    That is, left top position of placed windows. </li>
  <li> "MARGIN_X|Y": Margin between next windows. </li>
</ul>

<h3> SAMPLE </h3>
<ul>
  <li> BEFORE
    <img alt="before"
	 src="https://raw.githubusercontent.com/s-noda/shell_test/master/window_placer/images/desktop_capture_before.png"
	 style="width:50%;" />
  </li>
  <li> AFTER
    <img alt="after"
	 src="https://raw.githubusercontent.com/s-noda/shell_test/master/window_placer/images/desktop_capture_after.png"
	 style="width:50%";
	 />
  </li>
</ul>
