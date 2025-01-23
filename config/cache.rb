class Cache
  def set(key, value, expires_in_seconds = nil)
    if expires_in_seconds
      REDIS_CACHE.with { |redis|
        redis.setex(key, expires_in_seconds, value.to_s)
      }
    else
      REDIS_CACHE.with { |redis|
        redis.set(key, value.to_s)
      }
    end
  end

  def get(key)
    REDIS_CACHE.with { |redis|
      redis.get(key)
    }
  end

  def delete(key)
    REDIS_CACHE.with { |redis|
      redis.del(key)
    }
  end

  def clear(prefix)
    REDIS_CACHE.with { |redis|
      redis.keys("#{prefix}_*").each { |key|
        redis.del(key)
      }
    }
  end
end
