def is_num(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (ValueError, TypeError):
        pass
    return False


if __name__ == "__main__":
    pass
