declare-option str-list easy_motion_labels aa ab ac ad ae af ag ah ai aj ak al am an ao ap aq ar as at au av aw ax ay az ba bb bc bd be bf bg bh bi bj bk bl bm bn bo bp bq br bs bt bu bv bw bx by bz ca cb cc cd ce cf cg ch ci cj ck cl cm cn co cp cq cr cs ct cu cv cw cx cy cz da db dc dd de df dg dh di dj dk dl dm dn do dp dq dr ds dt du dv dw dx dy dz ea eb ec ed ee ef eg eh ei ej ek el em en eo ep eq er es et eu ev ew ex ey ez fa fb fc fd fe ff fg fh fi fj fk fl fm fn fo fp fq fr fs ft fu fv fw fx fy fz ga gb gc gd ge gf gg gh gi gj gk gl gm gn go gp gq gr gs gt gu gv gw gx gy gz ha hb hc hd he hf hg hh hi hj hk hl hm hn ho hp hq hr hs ht hu hv hw hx hy hz ia ib ic id ie if ig ih ii ij ik il im in io ip iq ir is it iu iv iw ix iy iz ja jb jc jd je jf jg jh ji jj jk jl jm jn jo jp jq jr js jt ju jv jw jx jy jz ka kb kc kd ke kf kg kh ki kj kk kl km kn ko kp kq kr ks kt ku kv kw kx ky kz la lb lc ld le lf lg lh li lj lk ll lm ln lo lp lq lr ls lt lu lv lw lx ly lz ma mb mc md me mf mg mh mi mj mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nb nc nd ne nf ng nh ni nj nk nl nm nn no np nq nr ns nt nu nv nw nx ny nz oa ob oc od oe of og oh oi oj ok ol om on oo op oq or os ot ou ov ow ox oy oz pa pb pc pd pe pf pg ph pi pj pk pl pm pn po pp pq pr ps pt pu pv pw px py pz qa qb qc qd qe qf qg qh qi qj qk ql qm qn qo qp qq qr qs qt qu qv qw qx qy qz ra rb rc rd re rf rg rh ri rj rk rl rm rn ro rp rq rr rs rt ru rv rw rx ry rz sa sb sc sd se sf sg sh si sj sk sl sm sn so sp sq sr ss st su sv sw sx sy sz ta tb tc td te tf tg th ti tj tk tl tm tn to tp tq tr ts tt tu tv tw tx ty tz ua ub uc ud ue uf ug uh ui uj uk ul um un uo up uq ur us ut uu uv uw ux uy uz va vb vc vd ve vf vg vh vi vj vk vl vm vn vo vp vq vr vs vt vu vv vw vx vy vz wa wb wc wd we wf wg wh wi wj wk wl wm wn wo wp wq wr ws wt wu wv ww wx wy wz xa xb xc xd xe xf xg xh xi xj xk xl xm xn xo xp xq xr xs xt xu xv xw xx xy xz ya yb yc yd ye yf yg yh yi yj yk yl ym yn yo yp yq yr ys yt yu yv yw yx yy yz za zb zc zd ze zf zg zh zi zj zk zl zm zn zo zp zq zr zs zt zu zv zw zx zy zz
declare-option range-specs easy_motion_ranges
declare-option str easy_motion_label_selection_map

set-face global EasyMotionBackground comment
set-face global EasyMotionLabel 'rgb:f07a2b+f'

add-highlighter shared/easy_motion group
add-highlighter shared/easy_motion/ fill EasyMotionBackground

define-command enter_easy_motion_replace_mode %{
  enter_easy_motion_mode 'easy_motion (replace):' %{
    execute-keys '<esc>z<esc>'
  }
}

define-command enter_easy_motion_extend_mode %{
  enter_easy_motion_mode 'easy_motion (extend):' %{
    execute-keys '<esc>,<a-z>u<esc>'
  }
}

define-command enter_easy_motion_append_mode %{
  enter_easy_motion_mode 'easy_motion (append):' %{
    execute-keys '<esc><a-z>a<esc>'
  }
}

define-command enter_easy_motion_mode -params 2 %{
  evaluate-commands -draft %{
    execute-keys 'gtGbxs\w+<ret><a-i>w<a-k>\A.{2,}\z<ret>)'
    create_new_easy_motion_state %val{selections_desc}
  }
  add-highlighter window/easy_motion ref easy_motion
  add-highlighter window/easy_motion_ranges replace-ranges easy_motion_ranges
  prompt %arg{1} %{
    exit_easy_motion_mode
  } -on-change %{
    handle_easy_motion_input %val{text} %arg{2}
  } -on-abort %{
    exit_easy_motion_mode
  }
}

define-command exit_easy_motion_mode %{
  unset-option window easy_motion_selections
  unset-option window easy_motion_ranges
  unset-option window easy_motion_label_selection_map
  remove-highlighter window/easy_motion
  remove-highlighter window/easy_motion_ranges
}

define-command create_new_easy_motion_state -params .. %{
  evaluate-commands %sh{
    jq -r -n '
      $ARGS.positional | map(split(",") | map(split(".") | map(tonumber))) as $kak_selections_desc |
      env.kak_opt_easy_motion_labels | split(" ") as $kak_opt_easy_motion_labels |
      $kak_selections_desc | keys |
      (["set-option", "window", "easy_motion_ranges", "%val{timestamp}", map("\($kak_selections_desc[.][0][0]).\($kak_selections_desc[.][0][1])+2|{EasyMotionLabel}\($kak_opt_easy_motion_labels[.])")[]] | join(" ")),
      (["set-option", "window", "easy_motion_label_selection_map", (map({($kak_opt_easy_motion_labels[.]):$kak_selections_desc[.]})|add|@json)] | join(" "))
    ' --args -- "$@"
  }
}

define-command handle_easy_motion_input -params 2 %{
  evaluate-commands %sh{
    jq -r -n '
      env.kak_opt_easy_motion_label_selection_map | fromjson |
      if has($ARGS.positional[0])
      then
        ["activate_easy_motion_label", $ARGS.positional[0], .[$ARGS.positional[0]][0][0], .[$ARGS.positional[0]][0][1], .[$ARGS.positional[0]][1][0], .[$ARGS.positional[0]][1][1], "%arg{2}"] | join(" ")
      else
        empty
      end
    ' --args -- "$@"
  }
}

define-command activate_easy_motion_label -params 6 %{
  evaluate-commands -save-regs '^' %{
    evaluate-commands -draft %{
      select "%arg{2}.%arg{3},%arg{4}.%arg{5}"
      execute-keys -save-regs '' 'Z'
    }
    evaluate-commands %arg{6}
  }
}

map -docstring 'enter_easy_motion_replace_mode' global normal f ':enter_easy_motion_replace_mode<ret>'
map -docstring 'enter_easy_motion_extend_mode' global normal F ':enter_easy_motion_extend_mode<ret>'
map -docstring 'enter_easy_motion_append_mode' global normal <a-f> ':enter_easy_motion_append_mode<ret>'
