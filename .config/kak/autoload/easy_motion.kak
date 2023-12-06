# https://git.sr.ht/~voroskoi/easymotion.kak
# https://github.com/danr/kakoune-easymotion
# https://github.com/postsolar/jump.kak
declare-option str-list jumpLabelsCharacters aa ab ac ad ae af ag ah ai aj ak al am an ao ap aq ar as at au av aw ax ay az ba bb bc bd be bf bg bh bi bj bk bl bm bn bo bp bq br bs bt bu bv bw bx by bz ca cb cc cd ce cf cg ch ci cj ck cl cm cn co cp cq cr cs ct cu cv cw cx cy cz da db dc dd de df dg dh di dj dk dl dm dn do dp dq dr ds dt du dv dw dx dy dz ea eb ec ed ee ef eg eh ei ej ek el em en eo ep eq er es et eu ev ew ex ey ez fa fb fc fd fe ff fg fh fi fj fk fl fm fn fo fp fq fr fs ft fu fv fw fx fy fz ga gb gc gd ge gf gg gh gi gj gk gl gm gn go gp gq gr gs gt gu gv gw gx gy gz ha hb hc hd he hf hg hh hi hj hk hl hm hn ho hp hq hr hs ht hu hv hw hx hy hz ia ib ic id ie if ig ih ii ij ik il im in io ip iq ir is it iu iv iw ix iy iz ja jb jc jd je jf jg jh ji jj jk jl jm jn jo jp jq jr js jt ju jv jw jx jy jz ka kb kc kd ke kf kg kh ki kj kk kl km kn ko kp kq kr ks kt ku kv kw kx ky kz la lb lc ld le lf lg lh li lj lk ll lm ln lo lp lq lr ls lt lu lv lw lx ly lz ma mb mc md me mf mg mh mi mj mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nb nc nd ne nf ng nh ni nj nk nl nm nn no np nq nr ns nt nu nv nw nx ny nz oa ob oc od oe of og oh oi oj ok ol om on oo op oq or os ot ou ov ow ox oy oz pa pb pc pd pe pf pg ph pi pj pk pl pm pn po pp pq pr ps pt pu pv pw px py pz qa qb qc qd qe qf qg qh qi qj qk ql qm qn qo qp qq qr qs qt qu qv qw qx qy qz ra rb rc rd re rf rg rh ri rj rk rl rm rn ro rp rq rr rs rt ru rv rw rx ry rz sa sb sc sd se sf sg sh si sj sk sl sm sn so sp sq sr ss st su sv sw sx sy sz ta tb tc td te tf tg th ti tj tk tl tm tn to tp tq tr ts tt tu tv tw tx ty tz ua ub uc ud ue uf ug uh ui uj uk ul um un uo up uq ur us ut uu uv uw ux uy uz va vb vc vd ve vf vg vh vi vj vk vl vm vn vo vp vq vr vs vt vu vv vw vx vy vz wa wb wc wd we wf wg wh wi wj wk wl wm wn wo wp wq wr ws wt wu wv ww wx wy wz xa xb xc xd xe xf xg xh xi xj xk xl xm xn xo xp xq xr xs xt xu xv xw xx xy xz ya yb yc yd ye yf yg yh yi yj yk yl ym yn yo yp yq yr ys yt yu yv yw yx yy yz za zb zc zd ze zf zg zh zi zj zk zl zm zn zo zp zq zr zs zt zu zv zw zx zy zz
set-face global JumpDimFace comment
set-face global JumpLabelFace 'rgb:f07a2b+fa'

decl range-specs jumpLabelsRanges
decl str-to-str-map jumpLabelToSelection

add-highlighter shared/jump group
add-highlighter shared/jump/ fill JumpDimFace
add-highlighter global/ replace-ranges jumpLabelsRanges

define-command jumpPrepareJump %{
  eval -draft -save-regs '' %{
    exec "gtGbx<a-s>gh%val{window_width}L"
    execute-keys 's.<ret><a-i>w'
    set-option window jumpLabelsRanges %val{timestamp}
    reg a %val{selections_desc}
    reg b %opt{jumpLabelsCharacters}
    edit -scratch
    exec -save-regs '' '"a<a-R>Za<ret><esc>zxypIset-option -add window jumpLabelToSelection "<c-r>b=<esc>A"<esc>kghf,;GldIset-option -add window jumpLabelsRanges "<esc>A+2|{JumpLabelFace}<c-r>b"<esc>%"zy'
    db
  }
  eval %reg{z}
  eval -draft -save-regs '"' %{
    reg dquote %opt{jumpLabelToSelection}
    edit -scratch '*jump*'
    exec '%<a-R>a<ret><esc>I"<esc>A"<esc>'
  }
  add-highlighter window/jump ref jump
}

define-command -hidden jumpRemoveHighlighters %{
  unset-option window jumpLabelsRanges
  remove-highlighter window/jump
  delete-buffer '*jump*'
}

define-command jumpOnPromptChangeImpl %{
  eval -draft -save-regs '/' %{
    buffer '*jump*'
    reg / """\Q%val{text}=\E(\d+\.\d+,\d+\.\d+)\b"""
    exec '%1s<ret>"zy'
  }
  exec '<esc>'
}

define-command jumpOnPromptChange %{
  try %{
    jumpOnPromptChangeImpl
    select "%reg{z}"
  }
}

define-command jumpExtendOnPromptChange %{
  try %{
    jumpOnPromptChangeImpl
    exec -save-regs '' ',Z'
    select "%reg{z}"
    exec -save-regs '' '<a-z>u'
  }
}

define-command jumpAppendOnPromptChange %{
  try %{
    jumpOnPromptChangeImpl
    exec -save-regs '' 'Z'
    select "%reg{z}"
    exec -save-regs '' '<a-z>a'
  }
}

define-command jumpOnPromptSubmit %{
  jumpRemoveHighlighters
}

define-command jumpJump %{
  jumpPrepareJump
  prompt 'Jump to: ' -on-change jumpOnPromptChange -on-abort jumpRemoveHighlighters jumpOnPromptSubmit
}

define-command jumpExtend %{
  jumpPrepareJump
  prompt 'Jump to: ' -on-change jumpExtendOnPromptChange -on-abort jumpRemoveHighlighters jumpOnPromptSubmit
}

define-command jumpAppend %{
  jumpPrepareJump
  prompt 'Jump to: ' -on-change jumpAppendOnPromptChange -on-abort jumpRemoveHighlighters jumpOnPromptSubmit
}
map global normal f :jumpJump<ret>
map global normal F :jumpExtend<ret>
map global normal <a-f> :jumpAppend<ret>
