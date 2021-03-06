%%{
  machine actions;

  action mark_start{
    mark = p
  }

  action fetch_scheme{
    @scheme = data[0..p-1]
  }

  action fetch_host{
    @host = data[mark..p-1]
  }

  action fetch_userinfo{
    @userinfo = data[mark..p-1]
    @username, @password = @userinfo.split(":")
  }

  action fetch_port{
    @port = data[mark..p-1].to_i
  }

  action fetch_path{
    @path = data[mark..p-1]
  }

  action fetch_query{
    @query = data[mark..p-1]
  }

  action fetch_fragment{
    @fragment = data[mark..p-1]
  }

# Actions for SIP URI
  action fetch_uri_params{
    data[mark..p-1].split(";").each do |param|
      next if param.empty?
      k,v = param.split("=")
      @param[k.to_sym] = v
    end
  }
  action fetch_sipuri_header{
    k,v = data[mark..p-1].split("=")
    @header[k.to_sym] = URI.unescape(v)
  }
}%%
