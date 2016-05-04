package com.xmbl.ops.itstack.utils;

import com.sun.tools.javac.util.List;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;

public abstract class TimeDecoder extends ByteToMessageDecoder { // (1)

	   protected void decode(ChannelHandlerContext ctx, ByteBuf in,

	         List<Object>out) throws Exception {

	      if (in.readableBytes()< 4) {

	           return;

	       }

	       out.add(new UnixTime(in.readInt()));

	   }

	}