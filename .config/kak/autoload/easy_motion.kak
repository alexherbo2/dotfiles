# https://git.sr.ht/~voroskoi/easymotion.kak
# https://github.com/danr/kakoune-easymotion
# https://github.com/postsolar/jump.kak
declare-option -hidden str-list easy_motion_labels aa ab ac ad ae af ag ah ai aj ak al am an ao ap aq ar as at au av aw ax ay az ba bb bc bd be bf bg bh bi bj bk bl bm bn bo bp bq br bs bt bu bv bw bx by bz ca cb cc cd ce cf cg ch ci cj ck cl cm cn co cp cq cr cs ct cu cv cw cx cy cz da db dc dd de df dg dh di dj dk dl dm dn do dp dq dr ds dt du dv dw dx dy dz ea eb ec ed ee ef eg eh ei ej ek el em en eo ep eq er es et eu ev ew ex ey ez fa fb fc fd fe ff fg fh fi fj fk fl fm fn fo fp fq fr fs ft fu fv fw fx fy fz ga gb gc gd ge gf gg gh gi gj gk gl gm gn go gp gq gr gs gt gu gv gw gx gy gz ha hb hc hd he hf hg hh hi hj hk hl hm hn ho hp hq hr hs ht hu hv hw hx hy hz ia ib ic id ie if ig ih ii ij ik il im in io ip iq ir is it iu iv iw ix iy iz ja jb jc jd je jf jg jh ji jj jk jl jm jn jo jp jq jr js jt ju jv jw jx jy jz ka kb kc kd ke kf kg kh ki kj kk kl km kn ko kp kq kr ks kt ku kv kw kx ky kz la lb lc ld le lf lg lh li lj lk ll lm ln lo lp lq lr ls lt lu lv lw lx ly lz ma mb mc md me mf mg mh mi mj mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nb nc nd ne nf ng nh ni nj nk nl nm nn no np nq nr ns nt nu nv nw nx ny nz oa ob oc od oe of og oh oi oj ok ol om on oo op oq or os ot ou ov ow ox oy oz pa pb pc pd pe pf pg ph pi pj pk pl pm pn po pp pq pr ps pt pu pv pw px py pz qa qb qc qd qe qf qg qh qi qj qk ql qm qn qo qp qq qr qs qt qu qv qw qx qy qz ra rb rc rd re rf rg rh ri rj rk rl rm rn ro rp rq rr rs rt ru rv rw rx ry rz sa sb sc sd se sf sg sh si sj sk sl sm sn so sp sq sr ss st su sv sw sx sy sz ta tb tc td te tf tg th ti tj tk tl tm tn to tp tq tr ts tt tu tv tw tx ty tz ua ub uc ud ue uf ug uh ui uj uk ul um un uo up uq ur us ut uu uv uw ux uy uz va vb vc vd ve vf vg vh vi vj vk vl vm vn vo vp vq vr vs vt vu vv vw vx vy vz wa wb wc wd we wf wg wh wi wj wk wl wm wn wo wp wq wr ws wt wu wv ww wx wy wz xa xb xc xd xe xf xg xh xi xj xk xl xm xn xo xp xq xr xs xt xu xv xw xx xy xz ya yb yc yd ye yf yg yh yi yj yk yl ym yn yo yp yq yr ys yt yu yv yw yx yy yz za zb zc zd ze zf zg zh zi zj zk zl zm zn zo zp zq zr zs zt zu zv zw zx zy zz
declare-option -hidden str-list easy_motion_selections
declare-option -hidden range-specs easy_motion_ranges
declare-option -hidden str-to-str-map easy_motion_label_selection_map

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
    execute-keys 'gtGbxs\w+<ret><a-i>w<a-k>\A.{2,}\z<ret>'
    evaluate-commands -client %val{client} -verbatim create_easy_motion_state %val{selections_desc}
  }
  add-highlighter window/easy_motion ref easy_motion
  add-highlighter window/easy_motion_ranges replace-ranges easy_motion_ranges
  create_easy_motion_label_selection_map_option_buffer
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
  close_easy_motion_label_selection_map_option_buffer
}

define-command create_easy_motion_label_selection_map_option_buffer %{
  evaluate-commands -draft -save-regs '"' %exp{
    edit -scratch "easy_motion_label_selection_map@%val{client}.option"
    set-register dquote %opt{easy_motion_label_selection_map}
    execute-keys '<a-P>'
    set-option buffer easy_motion_selections %%val{selections_desc}
  }
}

define-command close_easy_motion_label_selection_map_option_buffer %{
  delete-buffer "easy_motion_label_selection_map@%val{client}.option"
}

define-command create_easy_motion_state -params .. %{
  evaluate-commands -save-regs 'abc' %{
    set-register a %arg{@}
    set-register b %opt{easy_motion_labels}
    edit -scratch
    execute-keys '"a<a-P>a<space><c-r>b<esc>'
    evaluate-commands -itersel %{
      execute-keys 's\A(\d+)\.(\d+),(\d+)\.(\d+) (\w+)\z<ret>'
      set-register dquote %exp{
        set-option -add window easy_motion_ranges "%reg{1}.%reg{2}+2|{EasyMotionLabel}%reg{5}"
        set-option -add window easy_motion_label_selection_map "%reg{5}=%reg{1}.%reg{2},%reg{3}.%reg{4}"
      }
      execute-keys 'R'
    }
    execute-keys -save-regs '' '%"cy'
    delete-buffer
    set-option window easy_motion_ranges %val{timestamp}
    evaluate-commands %reg{c}
  }
}

define-command handle_easy_motion_input -params 2 %{
  evaluate-commands -draft -save-regs '^/' -verbatim try %{
    buffer "easy_motion_label_selection_map@%val{client}.option"
    select %opt{easy_motion_selections}
    set-register / "\A\Q%arg{1}\E=(\d+\.\d+,\d+\.\d+)\z"
    execute-keys '1s<ret>'
    evaluate-commands -draft -client %val{client} %exp{
      select %val{selection}
      execute-keys -save-regs '' 'Z'
    }
    evaluate-commands -client %val{client} %arg{2}
  }
}

map -docstring 'enter_easy_motion_replace_mode' global normal f ':enter_easy_motion_replace_mode<ret>'
map -docstring 'enter_easy_motion_extend_mode' global normal F ':enter_easy_motion_extend_mode<ret>'
map -docstring 'enter_easy_motion_append_mode' global normal <a-f> ':enter_easy_motion_append_mode<ret>'
