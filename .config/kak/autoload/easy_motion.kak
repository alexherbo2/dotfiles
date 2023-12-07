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
add-highlighter global/easy_motion_ranges replace-ranges easy_motion_ranges

define-command easy_motion_enter_replace_mode %{
  easy_motion_enter_select_mode easy_motion_replace_mode: 'z'
}

define-command easy_motion_enter_extend_mode %{
  easy_motion_enter_select_mode easy_motion_extend_mode: ',<a-z>u'
}

define-command easy_motion_enter_append_mode %{
  easy_motion_enter_select_mode easy_motion_append_mode: '<a-z>a'
}

define-command easy_motion_enter_select_mode -params 2 %{
  easy_motion_on_begin
  prompt %arg{1} %{
    easy_motion_on_end
  } -on-change %{
    try %{
      easy_motion_match_with_label %val{text} %exp{
        execute-keys "<esc>%arg{2}<esc>"
      }
    }
  } -on-abort %{
    easy_motion_on_end
  }
}

define-command easy_motion_on_begin %{
  unset-option window easy_motion_selections
  unset-option window easy_motion_ranges
  unset-option window easy_motion_label_selection_map
  add-highlighter window/easy_motion ref easy_motion
  evaluate-commands -save-regs '"' %{
    evaluate-commands -draft -save-regs 'abc' %{
      execute-keys 'gtGbxs\w+<ret><a-i>w<a-k>\A.{2,}\z<ret>'
      set-register a %val{selections_desc}
      execute-keys '<a-;>;L'
      set-register b %val{selections_desc}
      set-register c %opt{easy_motion_labels}
      edit -scratch
      execute-keys '"a<a-P>a<space><esc>Z"bpa<space><esc><a-Z>u"cp<a-z>u'
      evaluate-commands -itersel %{
        execute-keys 's\A(\d+\.\d+,\d+\.\d+) (\d+\.\d+,\d+\.\d+) (\w+)\z<ret>'
        set-register dquote %exp{
          set-option -add window easy_motion_ranges "%reg{2}|{EasyMotionLabel}%reg{3}"
          set-option -add window easy_motion_label_selection_map "%reg{3}=%reg{1}"
        }
        execute-keys 'R'
      }
      execute-keys -save-regs '' '%y'
      delete-buffer
    }
    set-option window easy_motion_ranges %val{timestamp}
    evaluate-commands %reg{dquote}
  }
  easy_motion_create_label_selection_map_buffer %opt{easy_motion_label_selection_map}
}

define-command easy_motion_on_end %{
  unset-option window easy_motion_selections
  unset-option window easy_motion_ranges
  unset-option window easy_motion_label_selection_map
  remove-highlighter window/easy_motion
  easy_motion_close_label_selection_map_buffer
}

define-command easy_motion_create_label_selection_map_buffer -params .. %{
  evaluate-commands -draft -save-regs '"' %{
    edit -scratch "easy_motion_label_selection_map@%val{client}.option"
    set-register dquote %arg{@}
    execute-keys '<a-R>'
    set-option buffer easy_motion_selections %val{selections_desc}
  }
}

define-command easy_motion_close_label_selection_map_buffer %{
  delete-buffer "easy_motion_label_selection_map@%val{client}.option"
}

define-command easy_motion_match_with_label -params 2 %{
  evaluate-commands -draft -save-regs '^/' %{
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

map -docstring 'easy_motion_enter_replace_mode' global normal f ':easy_motion_enter_replace_mode<ret>'
map -docstring 'easy_motion_enter_extend_mode' global normal F ':easy_motion_enter_extend_mode<ret>'
map -docstring 'easy_motion_enter_append_mode' global normal <a-f> ':easy_motion_enter_append_mode<ret>'
